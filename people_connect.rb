module PeopleConnect
  class Person < ActiveRecord::Base
    validates :usn,   :presence => true,
                      :uniqueness => true
    validates :name,  :presence => true

    scope :usn_order,  order('people.usn')
    scope :name_order, order('people.name')
  end
 
  def clear_db
    Person.find(:all).each {|p| Person.destroy(p.id)}
  end

  def db_connect
=begin
    #postgres
    ActiveRecord::Base.establish_connection(
      :adapter => 'postgresql',
      :database => 'nonzero',
      :username => 'postgres-username'
      :password => 'postgres-password'
    #mysql
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "myuser",
      :password => "mypass",
      :database => "somedatabase"
    )
=end
    #sqlite
    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database  => "db/demo"
    )

  end

end

