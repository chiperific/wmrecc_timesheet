class AppDefaultController < ApplicationController

  def holidays
    holidays_sorted = Holiday.all.order(:month, :day, :float_day)
    year = params[:year].to_i || Date.today.year
    holidays = []
    holidays_sorted.each do |h|
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