class Department < ActiveRecord::Base
  has_many :users
  has_many :categories, dependent: :destroy

  validates :name, presence: true

end
