class DepartmentsController < ApplicationController
    def index
    @title = "Departments"

    @depts = Department.all
  end

  def create
  end

  def new
    @title = "Add Departments"
  end

  def edit
    @title = "Edit Departments"
    @dept = Department.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
