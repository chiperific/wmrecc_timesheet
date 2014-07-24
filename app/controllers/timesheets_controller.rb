class TimesheetsController < ApplicationController

  def index
    @user = User.find(params[:user_id])

    if params[:auth] == "over"
      @user_auth = @user.has_authority_over
      @user_auth_id_ary = @user_auth.pluck(:id)
      @title = "Your Team's Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user_auth_id_ary).order(approved: :desc).order(created_at: :desc).group(:timesheet_id).page(params[:page])
    else
      @title = "Your Timesheets"
      @timesheet_hours = TimesheetHour.where(user_id: @user.id).order(created_at: :desc).group(:timesheet_id).page(params[:page])
    end

  end

  def show

  end

  def new
    @title = "New Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.new
    @timesheet_date = Date.today

    @url = user_timesheets_path(@user.id)

    @timesheet_hours = Array.new(7) { 
      @timesheet.timesheet_hours.build(user_id: @user.id)
    }

    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def edit
    @title = "Edit Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @timesheet_date = Date.parse @timesheet.week_num_to_date_obj
    
    @url = user_timesheet_path(@user.id, @timesheet.id)

    @timesheet_hours = Array.new(7) { 
      @timesheet.timesheet_hours.find_or_initialize_by(user_id: @user.id)
    }


    @timesheet_categories = Array.new

    Category.where(department_id: @user.department_id).each do |cat|
      timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
      @timesheet_categories << timesheet_category
    end

  end

  def create
    @user = User.find(params[:user_id])
    @timesheet_date = Date.today

    # If the timesheet already exists, update it
    if Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year]).count > 0

      @timesheet = Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year]).first

      if @timesheet.update_attributes(timesheet_params)
        flash[:success] = "Timesheet updated"
        redirect_to user_timesheets_path(@user)
      else
        render 'new'
      end

    else

      @timesheet = Timesheet.new(timesheet_params)
      if @timesheet.save
        flash[:success] = "Timesheet submitted"
        redirect_to user_timesheets_path(@user)
      else
        render 'new'
      end

    end

  end

  def update
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])

    if @timesheet.update_attributes(timesheet_params)
      flash[:success] = "Timesheet updated"
      redirect_to user_timesheets_path(@user)
    else
      render 'edit'
    end

  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:week_num, :year,
      :timesheet_hours_attributes => [:id, :timesheet_id, :user_id, :weekday, :hours, :approved],
      :timesheet_categories_attributes => [:id, :timesheet_id, :user_id, :category_id, :hours, :approved]
    )
  end

end
