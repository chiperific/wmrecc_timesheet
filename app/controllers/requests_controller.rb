class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_requests, only: :show
  before_action :set_active_direct_reports, only: :show
  before_action :set_user
  

  def show
    @requests = set_requests
    @user = set_user
    @direct_reports_ary = set_active_direct_reports.map { |u| u.id }
    @dr_requests = Request.where( user_id: @direct_reports_ary).sort_by { |r| r.user.lname }.sort_by &:date
  end

  def new
  end

  def edit
    @request = set_request
  end

  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def approval_flow
    @request = Request.find(params[:id])
    @approve = params[:approve]
    @reviewed = params[:reviewed]

    if @request.update_attribute(:sv_approval, @approve)
      @request.update_attribute(:sv_reviewed, @reviewed)
      flash[:success] = "Request updated"
      redirect_to user_requests_path(params[:user_id])
    else
      flash[:error] = "Something went wrong :("
      redirect_to user_requests_path(params[:user_id])
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requests
      User.find(params[:user_id]).requests
    end

    def set_request
      if params[:id]
        User.find(params[:user_id]).requests.find(params[:id])
      end
    end

    def set_user
      User.find(params[:user_id])
    end

    def set_active_direct_reports
      User.where(supervisor_id: set_user.id).where(active: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:user_id, :date, :hours, :sv_approval, :sv_denied)
    end
end
