class AddColumnCompletedToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :completed, :boolean
  end
end
