module Migrations

  def migrate_001_up
    ActiveRecord::Schema.define do
      create_table :people do |t|
        t.text :name
        t.text :usn
        t.timestamps
      end 
      add_index :people, :usn
    end
  end

  def migrate_001_down
    ActiveRecord::Schema.define do
      drop_table :people
    end
  end
end
