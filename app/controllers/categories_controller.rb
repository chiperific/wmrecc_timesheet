class CategoriesController < ApplicationController

  before_action :require_admin
  
  def index
    @title = "Categories"
    @cats_active = Category.where(active: true)
    @cats_inactive = Category.where(active: false)
  end

  def create
    @category = Category.new(cat_params)

    if @category.save
      flash[:success] = "Category created"
      redirect_to categories_path
    else
      @active_status = @category.active
      @dept_array = dept_array
      render 'new'
    end
  end

  def new
    @title = "Add Categories"
    @category = Category.new
    @dept_array = dept_array
    @active_status = true
  end

  def edit
    @title = "Edit categories"
    @category = Category.find(params[:id])
    @active_status = @category.active
    @dept_array = dept_array
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(cat_params)
      flash[:success] = "Category updated"
      redirect_to categories_path
    else
      @active_status = @category.active
      @dept_array = dept_array
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

  private

  def cat_params
    params.require(:category).permit(:name, :active, :department_id)
  end

end
