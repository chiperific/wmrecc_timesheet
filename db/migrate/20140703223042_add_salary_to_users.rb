class AddSalaryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salary, :decimal, precision: 10, scale: 2
  end
end
