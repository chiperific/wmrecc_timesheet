class RemoveCatDefaultFromDepartments < ActiveRecord::Migration
  def change
    remove_column :departments, :cat_default, :integer
  end
end
