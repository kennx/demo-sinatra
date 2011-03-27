module PeopleConnect
  class Person < ActiveRecord::Base
    validates :usn,        :presence => true,
                           :uniqueness => true
    validates :first_name, :presence => true
    validates :last_name,  :presence => true

    scope :usn_order,  order('people.usn')
  end
 
  def clear_db
    Person.find(:all).each {|p| Person.destroy(p.id)}
  end

  def db_connect
    ActiveRecord::Base.establish_connection(connect_spec)
  end

  def connect_spec
    YAML.load_file('database.yml')['development']
  end

  def execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end
end

