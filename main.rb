require 'logger'
require 'sinatra' 
require 'haml' 
require 'active_record'
require_relative 'people_connect'
require_relative 'app_helpers' 

module PeopleList

  class App < Sinatra::Base
    include PeopleConnect

    dir = File.dirname(File.expand_path(__FILE__))
    set :public, "#{dir}/public"
    set :views, "#{dir}/views"

    ActiveRecord::Base.logger = Logger.new("ar.log")
    file_name = "#{dir}/logs/sql.log"
    ActiveSupport::Notifications.subscribe /^sql\./ do |*args| 
      self.log_query(file_name, args)
    end

    def initialize(*args)
      super
      db_connect
    end

    def self.log_query(file_name,args)
      File.open(file_name,'a') do |f|
        f.print "#{args[0]}|"
        f.print "#{args[1].strftime('%Y-%m-%d %H:%M:%S')}|"
        f.print "#{args[2].strftime('%Y-%m-%d %H:%M:%S')}|"
        f.print "#{args[2]-args[1]}|"
        f.print "#{args[4][:name]}|"
        f.print "#{args[4][:sql].strip.gsub(/\n/,'').squeeze(' ')}"
        f.puts
      end
    end

    helpers AppHelpers

    get '/' do
      @people = Person.usn_order
      haml :index
    end

    get '/name' do
      @people = Person.name_order
      haml :index
    end

    get '/person' do
      haml :person
    end

    post '/add' do
      @errors = create_person(params)
      @people = Person.find(:all)
      haml :index
    end

    not_found do
      haml :"404"
    end

    error do
      @msg = "ERROR!!! " + env['sinatra.error'].name
      haml :error
    end
  end
end
