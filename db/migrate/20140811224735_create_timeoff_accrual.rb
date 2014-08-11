class CreateTimeoffAccrual < ActiveRecord::Migration
  def change
    create_table :timeoff_accruals do |t|
      t.string :accrual_type,    default: "Annual"
      t.integer :app_default_id, default: 1
    end
  end
end
