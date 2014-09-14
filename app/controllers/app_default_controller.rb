class AppDefaultController < ApplicationController

  def holidays
    year = params[:year].to_i || Date.today.year

    # holidays = Holiday.all.as_json


    holidays = []
    Holiday.all.each do |h|
      #collect holidays for provided year, year before and year after
      (-1..1).each do |i|
        new_year = year + i
        date = h.occurence(new_year)
        holidays << { "name"=> h.name, "date"=> date.to_s }
      end
    end

    render text: holidays.to_json
  end

end