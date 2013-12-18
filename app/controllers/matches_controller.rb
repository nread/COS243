class MatchesController < ApplicationController
  
  def new
    contest = Contest.find(params[:contest_id])
    @match = contest.matches.build
  end
  
  def create
    contest = Contest.find(params[:contest_id])
    @match = contest.matches.build(acceptable_params)
    if @match.save then
      flash[:success] = "Match Created."
      redirect_to @match
    else
      render 'new'
    end
  end
  
  def show
    @match = Match.find(params[:id])
  end
  
  def index
    @contest = Contest.find(params[:contest_id])
    @matches = @contest.matches
  end
end
