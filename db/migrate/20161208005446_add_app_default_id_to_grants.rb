class AddAppDefaultIdToGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :grants, :app_default_id, :integer
  end
end
