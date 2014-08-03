class DepartmentsController < ApplicationController
  
  def index
    @title = "Departments"

    @depts_active = Department.where(active: true)
    @depts_inactive = Department.where(active: false)
  end

  def create
    @dept = Department.new(dept_params)

    if @dept.save
      flash[:success] = "Department created"
      redirect_to departments_path
    else
      render 'new'
    end

  end

  def new
    @title = "Add Departments"
    @dept = Department.new
    @active_status = true
  end

  def edit
    @title = "Edit Departments"
    @dept = Department.find(params[:id])
    @active_status = @dept.active
  end

  def update
    @dept = Department.find(params[:id])

    if @dept.update_attributes(dept_params)
      flash[:success] = "Department updated"
      redirect_to departments_path
    else
      @depts_active = Department.where(active: true)
      @depts_inactive = Department.where(active: false)
      render 'edit'
    end
  end

  def destroy
  end

  private

  def dept_params
    params.require(:department).permit(:name, :active)
  end
end
