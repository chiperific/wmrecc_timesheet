class DestroyTimeoffAccrual < ActiveRecord::Migration
  def change
    drop_table :timeoff_accruals
  end
end
