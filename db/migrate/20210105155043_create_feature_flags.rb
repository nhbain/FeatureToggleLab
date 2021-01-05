class CreateFeatureFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_flags do |t|
      t.string :name
      t.boolean :value, null:false, default:false
      t.string :mode, null:false, default:"Default"
      t.string :description

      t.timestamps
    end
  end
end
