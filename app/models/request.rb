class Request < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :date, :hours, presence: true
  validates :hours, numericality: { only_integer: true, greater_than: 0 }
end
