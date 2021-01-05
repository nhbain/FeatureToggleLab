class AddRoleIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :roleId, :integer, null:false, default: 0
  end
end
