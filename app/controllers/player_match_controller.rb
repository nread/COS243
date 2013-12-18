class PlayerMatchController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :destroy]
  
  def new
    player = Player.find(params[:player_id])
    @player_match = player.player_matches.build
  end
  
  def create
    player = Player.find(params[:player_id])
    @player_match = player.player_matches.build(acceptable_params)
    if @player_match.save then
      flash[:success] = "Player Match Created."
      redirect_to @player_match
    else
      render 'new'
    end
  end
  
  def destroy
  end
  
  def show
  end
  
  def index
  end
  
  def ensure_user_logged_in
    redirect_to login_path unless logged_in?
  end 
      
  private
  
  def acceptable_params
    params.require(:player_match).permit(:player_id, :match_id, :score, :result)
  end
  
end
