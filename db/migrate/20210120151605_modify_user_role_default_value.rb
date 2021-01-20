class ModifyUserRoleDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :roleId, :integer, null:false, default: 1
  end
end
