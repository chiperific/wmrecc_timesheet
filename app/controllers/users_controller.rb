class UsersController < ApplicationController

  def index
    @title = "Users"
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)
    @supervised_active_users = @active_users.where("supervisor_id IS NOT NULL")

    @departments = Department.where(active: true)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User created"
      redirect_to users_path
    else
      @dept_array = dept_array
      @super_array = super_array
      render 'new'
    end
  end

  def new
    @title = "Add User"
    @user = User.new
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Create password"
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Change password"
  end #edit

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to users_path
    else
      @dept_array = dept_array
      @super_array = super_array
      render 'edit'
    end
  end

  def destroy
  end

  def dept_array
    @dept_arry = Array.new
    @dept_arry << ["(no department)", nil]
    Department.all.sort_by { |d| d.name }.each do |d|
      ddl_arry = Array.new
      ddl_arry << d.name
      ddl_arry << d.id
      @dept_arry << ddl_arry
    end
    @dept_arry
  end

  def super_array
    @super_arry = Array.new
    @super_arry << ["(no supervisor)", nil]
    User.all.sort_by { |u| u.fname }.sort_by { |u| u.lname}.each do |u|
      user_arry = Array.new
      user_arry << (u.fname + " " + u.lname)
      user_arry << u.id
      @super_arry << user_arry
    end
    @super_arry
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :active, :department_id, :supervisor_id, :email, :password, :password_confirmation, :admin)
  end

end
