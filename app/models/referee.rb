class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
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
