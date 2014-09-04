require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems you're limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module WmreccTimesheet
  class Application < Rails::Application
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.bmp)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    #config.time_zone = 'Eastern Time (US & Canada)'

    WillPaginate.per_page = 4

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

class Date
  def num_weeks(year = Date.today.year)
    Date.new(year, 12, 28).cweek # magick date!
  end

  # create a fiscalweek based upon Config#StartMonths
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
end
