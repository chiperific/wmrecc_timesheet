class Usergrant < ApplicationRecord
  belongs_to :user
  belongs_to :grant

  validates :user_id, :grant_id, presence: true
  validates :percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

end
