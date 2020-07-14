class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :deliveries, :date, :date
  end
end
