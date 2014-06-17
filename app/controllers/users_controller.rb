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
    @active_def = true
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Create password"
  end

  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
    @active_def = @user.active
    @super_array = super_array
    @dept_array = dept_array
    @pw_lang = "Change password"
    
    @path_switch = path_switch
    
    if current_user.id == @user.id 
      @admin_disabled = true
    else
      @admin_disabled = false
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to path_switch
    else
      @dept_array = dept_array
      @super_array = super_array
      render 'edit'
    end
  end

  def destroy
  end

  def dept_array
    @dept_arry = Array.new([["(no department)", nil]])
    @dept_arry += Department.all.sort_by { |d| d.name }.map { |d| [d.name, d.id]}
    @dept_arry
  end

  def super_array
    @super_arry = Array.new([["(no supervisor)", nil]])
    sorted_arry = User.all.sort_by { |u| u.fname }.sort_by { |u| u.lname}
    @super_arry += sorted_arry.map { |u| [u.fname+" "+u.lname, u.id]}
    @super_arry
  end

  def path_switch
    if current_user.admin?
      users_path
    else
      root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :active, :department_id, :supervisor_id, :email, :password, :password_confirmation, :admin)
  end

end
