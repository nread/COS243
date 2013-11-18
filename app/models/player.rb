class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :player_matches
  has_many :matches, through: :player_matches
  
  validates :user_id, presence: true
  validates :contest_id, presence: true
  validates :description, :downloadable, :playable, presence: true
  
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
