# The base controller for all controllers in this application.
class ApplicationController < ActionController::Base

  # I don't know what this does, but I'm assuming it protects this controller
  # from forgery.
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user
  #filter_parameter_logging :password, :password_confirmation
  
  private
  
  # Gets the session for the user who is currently logged in. Returns nil
  # if that happens to be nobody.
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  # Gets the user who's logged in. Returns nil if whoever's using the page isn't
  # logged in.
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  # Requires that someone is actually logged in. This can be used in a
  # controller to restrict access to a whole host of actions, or in individual
  # views to restrict certain pages. 
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  # Similar to require_user, except that the user must also be an admin.
  def require_admin
    unless current_user.class == Admin
      store_location
      flash[:notice] = "You must be an administrator to access this page"
      redirect_to labs_url
      return false
    end
  end

  # Requires that nobody is logged in. This is mostly useful to ensure that
  # alredy logged-in users don't try to log in again (until they log out first,
  # at least).
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  # Saves the URL that the user's at right now. The user can later be redirected
  # back here with a call to redirect_back_or_default.
  def store_location
    session[:return_to] = request.request_uri
  end

  # Redirects the user back to the last location that was saved with
  # #store_location. If no location has been saved, then the user will instead
  # be redirected to the passed-in default.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
