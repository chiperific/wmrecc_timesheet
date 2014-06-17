class Category < ActiveRecord::Base
  belongs_to :department

  validates :name, :department_id, presence: true
end
