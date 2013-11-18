class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches, as: :manager
  
  validates :user_id, presence: true
  validates :referee_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, :start, :deadline, :contest_type, presence: true
  #validates :deadline, :timeliness => {:on_or_after => :now, :type => :datetime, :on_or_before => lambda { |record| record.start }}
  #validates :start, :timeliness => {:on_or_after => :now, :type => :datetime}
end
