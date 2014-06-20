class AddApprovalToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :sv_approval, :boolean, default: false
  end
end
