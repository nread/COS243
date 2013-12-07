class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  
  validates :manager, presence: true
  #validates :manager_type, presence: true
  validates :status, presence: true
  validates_date :completion, :on_or_before => lambda { Time.now.change(:usec =>0) }, :if => :check_completed_things
  validates_datetime :earliest_start, :if => :check_start_things
  validate :check_number_of_players
  
  def check_number_of_players
    if self.players && self.manager
      if self.players.count != self.manager.referee.players_per_game
        errors.add(:manager, "Too many/few players!")
      end 
    end 
  end
  
  def check_completed_things
    self.status == "Completed"
  end
  
  def check_start_things
    if self.status == "Completed"
      return false
    elsif self.status == "Started"
      return false
    else
      return true
    end
  end
end
