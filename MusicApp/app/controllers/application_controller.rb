class ApplicationController < ActionController::Base

  def current_user
    @user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def require_logout
    redirect_to users_url if logged_in?
  end

end
