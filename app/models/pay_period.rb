class PayPeriod < ActiveRecord::Base
  belongs_to :app_default

  validates_presence_of :period_type, :app_default_id
  validates_inclusion_of :period_type, in: ["Bi-weekly", "Weekly", "Semi-monthly", "Monthly"]
end