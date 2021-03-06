class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :player_matches
  has_many :matches, through: :player_matches
  
  validates :user, presence: true
  validates :contest, presence: true
  validates :name, presence: true, uniqueness: {scope: :contest}
  validates :description, presence: true
  validates :file_location, presence: true
  validate :check_location
  
  include Uploadable
end
