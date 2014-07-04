class Request < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :hours, :date, presence: true
  validates :hours, numericality: { greater_than: 0 }

  def notice_class(r) #highlighting table rows in _self_table.html.erb
    if r.sv_reviewed && r.sv_approval
      "bg-success text-success"
    elsif r.sv_reviewed && r.sv_approval == false
      "bg-danger text-danger"
    else
      " "
    end
  end

  def status(r) #turning reviewed and approval combinations into meaningful text
    if r.sv_reviewed && r.sv_approval
      "Approved"
    elsif r.sv_reviewed && r.sv_approval == false
      "Denied"
    else
      "Not Reviewed"
    end
  end

end
