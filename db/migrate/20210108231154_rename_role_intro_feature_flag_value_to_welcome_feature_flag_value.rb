class RenameRoleIntroFeatureFlagValueToWelcomeFeatureFlagValue < ActiveRecord::Migration[5.0]
  def change
    rename_column :roles, :introFeatureFlagValue, :userWelcomeFeatureFlagValue
  end
end
