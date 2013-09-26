class User < ActiveRecord::Base
  #attr_accessor :username, :password, :confirmation
  has_secure_password
end
