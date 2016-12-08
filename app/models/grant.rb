class Grant < ApplicationRecord
  validates_presence_of :name

  belongs_to :app_default, validate: true
end
