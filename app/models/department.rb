class Department < ActiveRecord::Base

  validates :name, :active, presence: true

end
