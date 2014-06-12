class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.boolean :active
      t.integer :department_id
      t.integer :supervisor_id
      t.string :email

      t.timestamps
    end
  end
end
