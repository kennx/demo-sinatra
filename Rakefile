require 'active_record'
require_relative 'migrations' 
require_relative 'people_connect'

desc 'migrations'
task :db_up do
  #rake DB_SEQ=001 db_up
  include PeopleConnect
  include Migrations

  seq = ENV["DB_SEQ"] || '001'
  db_connect
  send "migrate_#{seq}_up".to_sym
end

task :db_down do
  #rake DB_SEQ=001 db_down
  include PeopleConnect
  include Migrations

  seq = ENV["DB_SEQ"] || '001'
  db_connect
  send "migrate_#{seq}_down".to_sym
end

desc 'show db status'
task :show_db do
  include PeopleConnect

  db_connect
  puts "People\n------"
  begin
    Person.find(:all).each {|p| puts "name:#{p.first_name} #{p.last_name}  usn:#{p.usn}"}
  rescue
    puts 'people find failed'
  end
end

desc 'clear db tasks'
task :clear_db do
  include PeopleConnect

  db_connect
  clear_db
end
