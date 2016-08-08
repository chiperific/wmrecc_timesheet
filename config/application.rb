require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WmreccTimesheet
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.bmp)
    WillPaginate.per_page = 4
  end
end

class Date
  # open up the date class and add some new methods
  def num_weeks(year = Date.today.year)
    Date.new(year, 12, 28).cweek # magick date!
  end

  # create a fiscalweek based upon Config#StartMonths
  # fweek is number of weeks a given Date object is into the Fiscal year
  def fweek
    month_text = StartMonth.first.month
    month_num = Date::MONTHNAMES.index(month_text)

    start_of_fy = Date.new(self.year, month_num, 1)

    if self < start_of_fy
      start_of_fy = start_of_fy - 1.year
    end

    diff = start_of_fy.cweek - 1

    if self.cweek > diff
      fweek = self.cweek - diff
    else
      fweek = self.cweek + (num_weeks(self.year) - diff)
    end
    fweek
  end

  def business_days_in_year
    holiday_count = Holiday.all.count
    weekend_ary = []
    (1..12).each do |i|
      weekend_ary.concat Date.new(self.year, i, 1).all_saturdays_in_month
      weekend_ary.concat Date.new(self.year, i, 1).all_sundays_in_month
    end
    days_off = weekend_ary.count + holiday_count
    days_in_year = Date.new(self.year, 12, 31).yday

    business_days = days_in_year - days_off
  end

  def start_of_period
    pay_period_type = PayPeriod.first.period_type
    case pay_period_type
    when "Weekly"
      sop = Date.commercial(self.year, self.cweek, 1)
    when "Bi-weekly"
      if self.cweek.odd?
        sop = Date.commercial(self.year, self.cweek, 1)
      else
        sop = Date.commercial(self.year, self.cweek - 1, 1)
      end
    when "Monthly"
      sop = Date.new(self.year, self.month, 1)
    else #Annually and Semi-monthly both start the same
      start_month = Date::MONTHNAMES.index(StartMonth.first.month)
      sop = Date.new(self.year, start_month, 1)
    end
  end

  def end_of_period
    pay_period_type = PayPeriod.first.period_type
    case pay_period_type
    when "Weekly"
      eop = Date.commercial(self.year, self.cweek, 7)
    when "Bi-weekly"
      if self.cweek.even?
        eop = Date.commercial(self.year, self.cweek, 7)
      else
        eop = Date.commercial(self.year, self.cweek, 7) + 7.days
      end
    when "Monthly"
      eop = Date.new(self.year, self.month, -1)
    when "Semi-monthly"
      start_month = Date::MONTHNAMES.index(StartMonth.first.month)
      eop = Date.new(self.year, start_month + 5, -1)
    else #Annually
      eop = Date.new(self.year, 12, -1)
    end
  end
end
