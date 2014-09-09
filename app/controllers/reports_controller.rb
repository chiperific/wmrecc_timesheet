class ReportsController < ApplicationController
  def index
    @title = "Reports"
    @col_width = "col-xs-4 col-sm-2 col-md-2 col-lg-1"
  end

  def payroll
    @title = "Payroll"
  end

  def departments
  end

  def users
  end

  def categories
  end
 
end
