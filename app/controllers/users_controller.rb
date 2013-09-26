class UsersController < ApplicationController
	def new
		@user = User.new
	end
  def create
    permitted_params = params.require(:user).permit(:username, :password, :password_confirmation)
		@user = User.new(permitted_params)
    #@user = User.new(:username => params[:username],:password => params[:password])
    #render 'new'
    if @user.save then
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
  end
end