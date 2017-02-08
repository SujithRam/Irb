module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
    session[:email] = user.email
  end
  
  def log_in_student(user)
    session[:user_id_s] = user.id
    session[:email] = user.email
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id].nil?
      if (user_id_s = session[:user_id_s])
        @current_user ||= Registration.find_by(id: user_id_s)
      end
    else
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      end
    end
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  def logged_normuser?
    current_user.normuser == true
  end
  
  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    session.delete(:user_id_s)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  def currentadmin_user?(user)
    user.admin == true
  end
  
  def current_user?(user)
    user == current_user
  end
end
