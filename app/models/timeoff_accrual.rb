class TimeoffAccrual < ActiveRecord::Base
  validates_presence_of :accrual_type, :app_default_id
  validates_inclusion_of :accrual_type, in: ["Annual", "Weekly", "Bi-weekly"]

  belongs_to :app_default
end