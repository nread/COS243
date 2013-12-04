class PlayerMatch < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  
  validates :player_id, presence: true
  validates :match_id, presence: true
  validates :score, presence: true
  validates :result, presence: true
end
