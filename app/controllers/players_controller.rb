class PlayersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]
  # URL to ge to this method is /contests/contest_id/players/new
  def new
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build
  end
  
  # posting to /contests/contest_id/players
  def create
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build(acceptable_params)
    @player.user = current_user
    if @player.save then
      flash[:success] = "Player Created."
      redirect_to @player
		else
			render 'new'
		end
  end
    
  def show
    @player = Player.find(params[:id])
  end
  
    def index
      @players = Player.all
    end
  
  def edit 
  end
  
    
    def update
      if @player.update_attributes(acceptable_params) then
        flash[:edit] = "Sucessfully made updates to #{@player}"
        redirect_to @player
      else
        render 'edit'
      end
    end
        
    
  def destroy
    @player = Player.find(params[:id])
    if current_user?(@player.user) then
      @player.destroy
      flash[:success] = "Successfully deleted player"      
      redirect_to contest_players_path(@player.contest)
    else
      flash[:danger] = "Can't delete player."
      redirect_to root_path
    end 
  end
      
  
      
private
      
  def acceptable_params
    params.require(:player).permit(:name, :description, :downloadable, :playable, :contest_id, :upload)
  end
      
  def ensure_correct_user
    @player = Player.find(params[:id])
    redirect_to root_path, flash: { :danger => "Must be Logged in as correct user!" } unless current_user?(@player.user)
  end
   
  def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Must be Logged in as correct user!" } unless logged_in?
  end

end
