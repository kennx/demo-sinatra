module AppHelpers
  include PeopleConnect

  def format_errors(obj)
    return nil if obj.errors.size < 1
    errors = ''
    obj.errors.each do |fld,msg|
      errors << "error on #{fld}: #{msg}.  "
    end  
    errors
  end

  def create_person(params)
    person = Person.new(:name => params['name'], :usn => params['usn'])
    person.save
    format_errors(person)
  end
end
