class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :phone
      t.boolean :is_admin
    end
  end
end
