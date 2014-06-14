class RemoveDeptDefaultFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :dept_default, :integer
    add_column :departments, :cat_default, :integer
  end
end
