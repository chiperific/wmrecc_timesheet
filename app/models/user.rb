class User < ActiveRecord::Base
  #has_one :department
  belongs_to :department
  has_many :categories, through: :department
  before_save { email.downcase! }

  validates :fname, :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  has_secure_password
  validates :password, length: {minimum: 6}, on: :create
end
