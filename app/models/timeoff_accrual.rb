class TimeoffAccrual < ActiveRecord::Base
  validates_presence_of :type, :app_default_id

  belongs_to :app_default
end