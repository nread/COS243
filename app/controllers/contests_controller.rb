class ContestsController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_contest_creator, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @contest = current_user.contests.build
  end
  
  def create
    @contest = current_user.contests.build(acceptable_params)
    if @contest.save then
      flash[:success] = "Contest Created."
      redirect_to @contest
		else
			render 'new'
		end
  end
    
  def show
    @contest = Contest.find(params[:id])
  end
  
  def index
    @contests = Contest.all
  end
  
  def edit
  
  end
  
    
  def update
    if @contest.update_attributes(acceptable_params) then
      flash[:success] = "Sucessfully made updates to #{@contest.name}"
      redirect_to @contest
    else
      render 'edit'
    end
  end
    
  def destroy
    @contest = Contest.find(params[:id])
    if current_user
      @contest.destroy
      flash[:success] = "Successfully deleted contest"      
      redirect_to contests_path
    else
      flash[:danger] = "Contest was not deleted"
      redirect_to root_path
    end
  end
  
   def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in?
  end
    
  def ensure_contest_creator 
      redirect_to root_path, flash: { :danger => "You are not a contest creator!" } unless current_user.contest_creator?
  end
  
  def ensure_correct_user
    @contest = Contest.find(params[:id])
    redirect_to root_path, flash: { :danger => "Must be Logged in as correct user!" } unless current_user?(@contest.user)
  end   
  private
  
  def acceptable_params
    params.require(:contest).permit(:name, :description, :contest_type, :start, :deadline, :referee_id)
  end
       
  
end
