class AddTimeoffcarryoverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :timeoff_carryover, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
