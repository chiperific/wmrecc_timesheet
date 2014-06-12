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
  end

  def edit
    @title = "Edit profile"
  end

  def update
  end

  def destroy
  end
end
