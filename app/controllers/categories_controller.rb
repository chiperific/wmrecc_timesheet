class CategoriesController < ApplicationController

  before_action :require_admin, except: :payroll_users

  def index
    @title = "Categories"
    @cats_active = Category.where(active: true)
    @cats_inactive = Category.where(active: false)
  end

  def new
    @title = "Add Categories"
    @category = Category.new
    @dept_array = dept_array
    @active_status = true
    session[:return_url] = back_uri
  end

  def edit
    @title = "Edit categories"
    @category = Category.find(params[:id])
    @active_status = @category.active
    @dept_array = dept_array
    session[:return_url] = back_uri
  end

  def create
    @category = Category.new(cat_params)

    if @category.save
      flash[:success] = "Category created"
      redirect_to session[:return_url]
    else
      @active_status = @category.active
      @dept_array = dept_array
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(cat_params)
      flash[:success] = "Category updated"
      redirect_to session[:return_url]
    else
      @active_status = @category.active
      @dept_array = dept_array
      render 'edit'
    end
  end

  def payroll_users #json the users by category
    category = Category.find(params[:cat_id])
    payroll_start = params[:payroll_start].gsub("-","/").to_date
    payroll_end = params[:payroll_end].gsub("-","/").to_date
    timesheet_ids = Timesheet.where{ (start_date <= payroll_end) & (end_date >= payroll_start) }.map { |t| t.id } # thanks Squeel!!
    relevant_ts_cats = TimesheetCategory.where(timesheet_id: timesheet_ids, category_id: category.id).includes(:timesheet => :user).order('users.lname')
    ary = []
    relevant_ts_cats.each do |c|
      if c.hours > 0
        hours = number_with_precision(c.hours.round(2), precision: 2)
        rate = number_to_currency(c.timesheet.user.payroll_hourly_rate(payroll_start))
        subttl = number_to_currency(c.hours.to_f * c.timesheet.user.payroll_hourly_rate(payroll_start).to_f)
        ary << { "staff"=> c.timesheet.user.full_name, "hours"=> hours, "rate"=> rate, "subttl"=> subttl }
      end
    end
    render text: ary.to_json
  end

  def dept_array
    @dept_arry = Array.new([["(no department)", nil]])
    @dept_arry += Department.all.sort_by { |d| d.name }.map { |d| [d.name, d.id]}
    @dept_arry
  end

  private

  def cat_params
    params.require(:category).permit(:name, :active, :department_id)
  end

end
