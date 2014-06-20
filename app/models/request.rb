class Request < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :date, :hours, presence: true
end
