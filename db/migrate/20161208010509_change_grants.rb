class ChangeGrants < ActiveRecord::Migration[5.0]
  def change
    change_column :grants, :app_default_id, :integer, default: 1
  end
end
