class Holiday < ActiveRecord::Base
  validates_presence_of :name, :month

  belongs_to :app_default, validate: true

  def all_instances_in_month(year)
    start = Date.new year, self.month, 1
    array = []
    array[start.wday] = 1
    (2..start.end_of_month.mday).each { |i| array << i }
    week_split = array.each_slice(7).to_a
    instances = week_split.map{|d| d[self.float_day]}.compact
    instances
  end

  def occurence(year)
    if self.floating == false
      date = Date.new(year, self.month, self.day)
    else
      options = self.all_instances_in_month(year)
      selection = self.float_week - 1
      day = options[selection]
      date = Date.new(year, self.month, day)
    end
    date
  end

end
