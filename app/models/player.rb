class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :player_matches
  has_many :matches, through: :player_matches
  
  validates :user, presence: true
  validates :contest, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :file_location, presence: true
  validate :check_location
  
  def check_location
    if self.file_location && !File.exists?(self.file_location)
      errors.add(:file_location, "is invalid")
    end
  end 
  
  def upload=(uploaded_file)
    if uploaded_file.nil?
      #No file
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '-')
      file_location = Rails.root.join('code', 'players', Rails.env,  time_no_spaces).to_s
      IO::copy_stream(uploaded_file, file_location)
    end
    self.file_location = file_location
  end
end
