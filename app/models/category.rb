class Category < ActiveRecord::Base

  validates :name, :department_id, :active, presence: true
end
