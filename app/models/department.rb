class Department < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :users

  validates :name, presence: true

end
