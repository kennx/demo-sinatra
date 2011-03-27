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
    person = Person.new(params)
    person.save
    format_errors(person)
  end

  def find_people(params)
    unless params[:usn].empty?
      Person.find_all_by_usn(params[:usn])
    else
      Person.find_all_by_first_name_and_last_name(params[:first_name],params[:last_name])
    end
  end
end
