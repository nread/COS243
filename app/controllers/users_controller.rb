class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only:[:edit,:update,:index]
  before_action :ensure_correct_user, only:[:edit,:update]
  before_action :ensure_admin_user, only:[:destroy]
  def new #to get the login form
		@user = User.new
	end
  
  def create #to create the user and add to DB
		@user = User.new(permitted_params)
    if @user.save then
      flash[:success] = "Welcome"
      cookies.signed[:user_id] = @user.id
      redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
  end
    
  def show
    @user = User.find(params[:id])
  end
    
  def index
    @users = User.all
  end
    
  def edit
#    @user = User.find(params[:id])
  end
    
  def update
    @user = User.find(params[:id])
    /if !@user=current_user? then
      flash[:warning] = "Cannot edit this user"
      redirect_to root_path
    else/
      if @user.update(permitted_params) then
        flash[:success] = "Successfully made updates to #{@username}"
			  redirect_to @user
		  else
        render 'edit'
      end
		/end/
  end
    
  def destroy
    @user = User.find(params[:id])
    if @user.admin
      redirect_to root_path
    end
    @user.destroy
    flash[:success] = "Successfully deleted user"      
    redirect_to users_path
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
    
  private 
    def permitted_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end
