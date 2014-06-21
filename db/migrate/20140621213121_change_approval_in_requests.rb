class ChangeApprovalInRequests < ActiveRecord::Migration
  def change
    rename_column :requests, :sv_denied, :sv_reviewed
  end
end
