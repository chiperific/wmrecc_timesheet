class ItEmail < ActiveRecord::Base
  belongs_to :app_default, validate: true

  validates_presence_of :app_default_id

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
