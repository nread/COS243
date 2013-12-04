class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  
  validates :manager, presence: true
  validates :manager_type, presence: true
  validates :status, presence: true
  validates_date :completion
  validates_datetime :earliest_start
  validates :match_id, presence: true
end
