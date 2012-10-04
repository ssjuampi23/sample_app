class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false #default FALSE means that by default the users are not administrators
  end
end
