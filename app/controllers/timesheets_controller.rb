class TimesheetsController < ApplicationController

  before_action do
    require_self_sv_or_admin(User.find(params[:user_id]))
  end

  def single
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    if current_user == @user
      @page_title = "Your Timesheets"
    else
      @page_title = "#{@user.fname}'s Timesheets"
    end
    @timesheet = Timesheet.joins(:timesheet_hours).where( timesheet_hours: { user_id: @user.id }).uniq
  end

  def supervisor
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    @page_title = "Your Team's Timesheets"

    @user_auth = @user.has_authority_over
    if !@user_auth.empty?
      @user_id_ary = @user_auth.pluck(:id)
    else
      @user_id_ary = []
    end

    @users_select = Hash.new
    @user_auth.each do |usr|
      @users_select[usr.full_name] = usr.id
    end
  end

  def admin
    @title = "Timesheet"
    @user = User.find(params[:user_id])
    @page_title = "All Timesheets"
    @user_id_ary = User.all.map { |u| u.id }
    
    @users_select = Hash.new
    User.where(active: true).order(:lname).each do |usr|
      @users_select[usr.full_name] = usr.id
    end
  end

  def new
    @title = "New Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.new
    @timesheet_date = Date.today

    @hours_reviewed = ["Unreviewed", false]
    @hours_approved = ["Unapproved", false]
    @timeoff_hours_reviewed = ["Unreviewed", false]
    @timeoff_hours_approved = ["Unapproved", false]


    @url = user_timesheets_path(@user.id)

    @timesheet_hours = weekday_ary

    @timesheet_categories = categories_ary

    session[:return_url] = back_uri

    @hours_ttl = 0.0
    @category_ttl = 0.0
  end

  def edit
    @title = "Edit Timesheet"
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])
    @timesheet_date = DateTime.parse @timesheet.week_num_to_date_obj
    @hours = @timesheet.timesheet_hours.where(user_id: @user.id).first
    if !@hours.nil?
      @hours_approved = @hours.approved?
      @hours_reviewed = @hours.reviewed?
      @timeoff_hours_reviewed = @hours.timeoff_reviewed?
      @timeoff_hours_approved = @hours.timeoff_approved?
    else
      @hours_approved = false
      @hours_reviewed = false
      @timeoff_hours_reviewed = false
      @timeoff_hours_approved = false
    end
    
    @url = user_timesheet_path(@user.id, @timesheet.id)

    @timesheet_hours = weekday_ary

    @timesheet_categories = categories_ary

    session[:return_url] = back_uri

    @ts_collection = @timesheet.timesheet_hours.where(user_id: @user.id)

    @hours_ttl = @ts_collection.sum(:hours) + @ts_collection.sum(:timeoff_hours)
    @category_ttl = @timesheet.timesheet_categories.where(user_id: @user.id).sum(:hours)
  end

  def create
    @user = User.find(params[:user_id])
    @timesheet_date = Date.today

    # If the timesheet already exists, update it
    if Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year]).exists?

      @timesheet_ary = Timesheet.where( week_num: params[:timesheet][:week_num], year: params[:timesheet][:year])
      @timesheet = @timesheet_ary.first

      # If the each Timesheet Hour already exists, update it, else, create it.
      params['timesheet']['timesheet_hours_attributes'].each do |th_a|
        th = th_a.second
        th.delete("id")
        th['timesheet_id'] = @timesheet.id
        if TimesheetHour.where( user_id: @user.id, timesheet_id: @timesheet.id, weekday: th['weekday'] ).exists?
          # update
          th_r = TimesheetHour.where( user_id: @user.id, timesheet_id: @timesheet.id, weekday: th['weekday'] ).first
          th_r.update(th)
        else
          # create
          TimesheetHour.create(th)
        end
      end

      # If the each Timesheet Category already exists, update it, else, create it.
      params['timesheet']['timesheet_categories_attributes'].each do |tc_a|
        tc = tc_a.second
        tc.delete("id")
        tc['timesheet_id'] = @timesheet.id
        if TimesheetCategory.where( user_id: @user.id, timesheet_id: @timesheet.id, category_id: tc['category_id'] ).exists?
          # update
          tc_r = TimesheetCategory.where( user_id: @user.id, timesheet_id: @timesheet.id, category_id: tc['category_id'] ).first
          tc_r.update(tc)
        else
          # create
          TimesheetCategory.create(tc)
        end
      end

      # if @timesheet.update_attributes(timesheet_params)
      #   flash[:success] = "Timesheet updated"
      #   redirect_to session[:return_url]
      # else
      #   flash[:error] = "Failed to submit"
      #   render 'new'
      # end

      flash[:success] = "Timesheet updated"
      redirect_to session[:return_url]

    else
      @timesheet = Timesheet.new(timesheet_params)
      if @timesheet.save
        flash[:success] = "Timesheet submitted"
        redirect_to session[:return_url]
      else
        flash[:error] = "Failed to submit"
        render 'new'
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @timesheet = Timesheet.find(params[:id])

    if @timesheet.update_attributes(timesheet_params)
      flash[:success] = "Timesheet updated"
      redirect_to session[:return_url]
    else
      flash[:error] = "Failed to update"
      render 'edit'
    end
  end

  private

    def timesheet_params
      params.require(:timesheet).permit(:week_num, :year,
        :timesheet_hours_attributes =>      [:id, :timesheet_id, :user_id, :weekday, :hours, :reviewed, :approved, :timeoff_hours, :timeoff_reviewed, :timeoff_approved],
        :timesheet_categories_attributes => [:id, :timesheet_id, :user_id, :hours, :category_id]
      )
    end

    def timesheet_hour_params
      params.require(:timesheet_hours_attributes).permit(
        :id, :timesheet_id, :user_id, :weekday, :hours, :reviewed, :approved, :timeoff_hours, :timeoff_reviewed, :timeoff_approved
      )
    end

    # for defaul select_tag values on _timesheet_approval_form
    def reviewed?
      if self.reviewed.blank?
        ["Unreviewed", false]
      else
        ["Reviewed", true]
      end
    end

    def approved?
      if self.approved.blank?
        ["Unapproved", false]
      else
        ["Approved", true]
      end
    end

    def timeoff_reviewed?
      if self.timeoff_reviewed.blank?
        ["Unreviewed", true]
      else
        ["Reviewed", true]
      end
    end

    def timeoff_approved?
      if self.timeoff_approved.blank?
        ["Unapproved", false]
      else
        ["Approved", true]
      end
    end

    def weekday_ary
      timesheet_hours = Array.new

      Weekday.all.order(:day_num).each do |wd|
        timesheet_hour = @timesheet.timesheet_hours.find_or_initialize_by(user_id: @user.id, weekday: wd.day_num)
        timesheet_hours << timesheet_hour
      end
      timesheet_hours
    end

    def categories_ary
      timesheet_categories = Array.new

      Category.where(department_id: @user.department_id).each do |cat|
        timesheet_category = @timesheet.timesheet_categories.find_or_initialize_by(user_id: @user.id, category_id: cat.id)
        timesheet_categories << timesheet_category
      end
      timesheet_categories
    end

  #end private
end
