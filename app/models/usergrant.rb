class Usergrant < ApplicationRecord
  belongs_to :user
  belongs_to :grant

  validates :user_id, :grant_id, :active, presence: true

end
