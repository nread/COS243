class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
  validates :user_id, :name, :rules_url, :players_per_game, :file_location, presence: true
  validates_format_of :rules_url, :with => URI::regexp(%w(http https))
  validates_uniqueness_of :name

  #validates_format_of :rules_url, :with=> /^(https?:\/\/)?w{3}[\.][^\.]*[\.][^.]+$/i
  validates :players_per_game, :numericality => {only_integer: true}
  validates :players_per_game, :numericality => {greater_than_or_equal_to: 1}
  validates :players_per_game, :numericality => {less_than_or_equal_to: 10}
  
  def upload=(uploaded_file)
    if uploaded_file.nil?
      #No file
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '-')
      file_location = Rails.root.join('code', 'referees', Rails.env,  time_no_spaces).to_s
      IO::copy_stream(uploaded_file, file_location)
    end
    self.file_location = file_location
  end
end
