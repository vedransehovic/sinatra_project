class CreateRecepients < ActiveRecord::Migration
  def change
    create_table :recepients do |t|
      t.string :name
      t.string :address
      t.string :municipality
      t.string :phone
    end
  end
end
