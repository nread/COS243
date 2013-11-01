class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    @user = User.find_by(username: params[:username])
    @user = 
    if @user && @user.authenticate(params[:password])
      cookies.signed[:user_id] = @user.id
      flash[:success] = "#{@user.username} logged on"
      redirect_to @user
    else
      flash.now[:danger] = "Invalid username or password"
      render 'new'
    end
  end
    
  def destroy
    cookies.signed[:user_id] = nil
    flash[:logged_out]
    redirect_to login_path
  end
end
