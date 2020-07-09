class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :task
      t.datetime :date
      t.integer :recepients_id
      t.integer :volunteer_id
    end
  end
end
