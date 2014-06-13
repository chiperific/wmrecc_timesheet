class UsersController < ApplicationController
  def index
    @title = "Users"
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)

    @supervised_active_users = @active_users.where("supervisor_id IS NOT NULL")

    @departments = Department.where(active: true)
  end

  def create
  end

  def new
    @title = "Add User"
    @user = User.new
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])

    
    @super_array = Array.new
    @super_array << ["(no supervisor)", nil]
    User.all.sort_by { |u| u.fname }.sort_by { |u| u.lname}.each do |u|
      user_array = Array.new
      user_array << (u.fname + " " + u.lname)
      user_array << u.id
      @super_array << user_array
    end

    @dept_array = Array.new
    @dept_array << ["(no department)", nil]
    Department.all.sort_by { |d| d.name }.each do |d|
      ddl_array = Array.new
      ddl_array << d.name
      ddl_array << d.id
      @dept_array << ddl_array
    end

  end #edit

  def update
  end

  def destroy
  end
end
