class Category < ActiveRecord::Base
  belongs_to :department

  validates :name, :department_id, :active, presence: true

end
