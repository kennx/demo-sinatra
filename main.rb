require 'logger'
require 'sinatra' 
require 'haml' 
require 'active_record'
require_relative 'people_connect'
require_relative 'app_helpers' 

module PeopleList

  class App < Sinatra::Base
    include PeopleConnect
    ActiveRecord::Base.logger = Logger.new("ar.log")

    dir = File.dirname(File.expand_path(__FILE__))
    set :public, "#{dir}/public"
    set :views, "#{dir}/views"

    def initialize(*args)
      super
      db_connect
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
