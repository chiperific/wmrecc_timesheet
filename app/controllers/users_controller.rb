class UsersController < ApplicationController
  def index
    @title = "Users"
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)
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
