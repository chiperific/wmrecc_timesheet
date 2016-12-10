class Grant < ApplicationRecord
  validates_presence_of :name

  belongs_to :app_default, validate: true

  has_many :usergrants
  has_many :users, through: :usergrants

  has_many :timesheet_grants
  has_many :timesheets, through: :timesheet_grants
end
