module Migrations

  def migrate_001_up
    ActiveRecord::Schema.define do
      create_table :people do |t|
        t.string :first_name
        t.string :last_name
        t.string :usn
        t.timestamps
      end 
      add_index :people, :usn
      add_index :people, :last_name
    end
  end

  def migrate_001_down
    ActiveRecord::Schema.define do
      drop_table :people
    end
  end
end
