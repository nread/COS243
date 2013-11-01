class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches, as: :manager
end
