class AppDefaultController < ApplicationController

  def holidays
    year = params[:year].to_i || Date.today.year

    # holidays = Holiday.all.as_json


    holidays = []
    Holiday.all.each do |h|
      date = h.occurence(year)
      holidays << { "name"=> h.name, "date"=> date.to_s }
    end

    render text: holidays.to_json
  end

end