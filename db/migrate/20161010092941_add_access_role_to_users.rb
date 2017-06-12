class AddAccessRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_role, :integer,    default: 3
  end
end
