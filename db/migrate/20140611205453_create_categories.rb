class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :department_id
      t.boolean :active
      t.boolean :dept_default

      t.timestamps
    end
  end
end
