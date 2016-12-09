class Grant < ApplicationRecord
  validates_presence_of :name

  belongs_to :app_default, validate: true

  has_many :usergrants
  has_many :users, through: :usergrants
end
