class Holiday < ActiveRecord::Base
  validates :name, :month, presence: true
  belongs_to :app_default, validate: true

  def occurence(year)
    if self.floating == false
      date = Date.new year, self.month, self.day
    else
      date = Date.today
    end

    date.strftime("%m/%d/%y")
  end

end
