class TimesheetsController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    @user_auth = @user.has_authority_over
    @user_auth_id_ary = @user_auth.pluck(:id)

    if params[:auth] == "over"
      @title = "Your Team's Timesheets"
      @timesheets = TimesheetHour.where(user_id: @user_auth_id_ary).order("created_at DESC").group(:timesheet_id).page(params[:page])
    else
      @title = "Your Timesheets"
      @timesheets = TimesheetHour.where(user_id: @user.id).order("created_at DESC").group(:timesheet_id).page(params[:page])
    end

  end

  def show
    @title = "Timesheets for #{@user.fname}"
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

end
