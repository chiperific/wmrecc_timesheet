class User < ActiveRecord::Base
  include SessionsHelper

  belongs_to :department
  has_many :categories, through: :department
  has_many :requests
  has_many :timesheet_hours
  has_many :timesheet_categories

  accepts_nested_attributes_for :requests, reject_if: lambda { |a| a[:date].blank? || a[:hours].blank? }

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :fname, :lname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def has_authority_over
    if User.where(supervisor_id: self.id).count > 0
      User.where(supervisor_id: self.id)
    else
      []
    end
  end


  def full_name
    "#{self.fname} #{self.lname}"
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
