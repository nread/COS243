module SessionsHelper
  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def logged_in?
    !current_user.nil?
  end
  
  def sign_in(user)
    @current_user ||= user.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
end
