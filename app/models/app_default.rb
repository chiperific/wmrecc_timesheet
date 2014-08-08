class AppDefault < ActiveRecord::Base
  validates :name, presence: true
end