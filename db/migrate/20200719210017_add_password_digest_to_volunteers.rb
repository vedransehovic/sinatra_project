class AddPasswordDigestToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :password_digest, :text
    add_column :volunteers, :email, :text
  end
end
