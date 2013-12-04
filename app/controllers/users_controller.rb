class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only:[:edit,:update,:index]
  before_action :ensure_correct_user, only:[:edit,:update]
  before_action :ensure_admin_user, only:[:destroy]
  before_action :ensure_not_logged_in, only: [:new, :create]
  
  respond_to :html, :json, :xml #lists all of the data types that you mkight expect to recieve
  
  def new #to get the login form
		@user = User.new
    respond_with(@user)
	end
  
  def create #to create the user and add to DB
		@user = User.new(permitted_params)
    if @user.save then
      flash[:success] = "Welcome"
      cookies.signed[:user_id] = @user.id
		end
    respond_with(@user)
  end
    
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end
    
  def index
    @users = User.all
    respond_with(@users)
  end
    
  def edit
  end
    
  def update
    @user = User.find(params[:id])
      if @user.update(permitted_params) then
        flash[:success] = "Successfully made updates to #{@username}"
      end
      respond_with(@user)
  end
    
  def destroy
    @user = User.find(params[:id])
    if @user.admin
      redirect_to root_path
    end
    @user.destroy
    flash[:success] = "Successfully deleted user"      
    #redirect_to users_path
    respond_with(@user)
  end  
  
  def ensure_user_logged_in
    redirect_to login_path unless logged_in?
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
    
  def ensure_admin_user
      redirect_to users_path unless current_user.admin?
  end
    
  def ensure_not_logged_in
    redirect_to root_path, flash: { :warning => "You are logged in and cannot perform that action!" } unless !logged_in?
  end  
    
  private 
    def permitted_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end
