class RenameColumnRecepients < ActiveRecord::Migration
  def change
    rename_column :deliveries, :recepients_id, :recepient_id
  end
end
