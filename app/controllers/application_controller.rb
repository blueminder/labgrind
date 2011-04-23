# The base controller for all controllers in this application.
# Also this, is how authentication itself works. If you wish to disable access
# to a project, if not logged in (which you should always do unless you don't),
# you want to add
# before_filter :require_user
# If you want to limit it for only some methods, you want:
# before_filter :require_user, :except => [:new, :create]
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

  # Prohibits access to this page for anyone not currently logged in. If not
  # logged on, it redirects to new_user_session_url.
  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_back_or_default(new_user_session_url)
      return false
    end
    true
  end

  # Prohibits access to this page except to a specific user or lab admin.
  def require_specific_user(user)
    unless current_user == user or current_user.is_admin?
      flash[:notice] = "Only #{user.username} can see their own details"
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page unless the current user is a site
  # administrator or a lab admin.
  def require_admin
    unless current_user.is_admin?
      flash[:notice] = "You must be some sort of administrator to access this page"
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page unless the current user is a site
  # administrator
  def require_super_admin
    unless current_user.is_super_admin?
      flash[:notice] = "You must be a super-administrator to access this page"
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page unless the current user is a lab admin
  # for the appropriate lab.
  def require_lab_admin(lab)
    unless current_user.administers_lab?(lab)
      flash[:notice] =
        "You must be an administrator of #{lab.name} to access this page"
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page unless the current user is a project owner
  # or a site administrator.
  def require_project_owner(project)
    unless current_user.owns? project or current_user.is_super_admin?
      flash[:notice] = 
        "Only owners of this project can access that."
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page unless the current user is a project member
  # or a site administrator.
  def require_project_member(project)
    unless current_user.belongs_to? project or current_user.is_super_admin?
      flash[:notice] =
        "Only members of that project can access that."
      redirect_back_or_default(current_user.becomes User)
      return false
    end
    true
  end

  # Prohibits access to this page if the user is logged in. In other words,
  # this should be required only for the login or registration pages.
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to(current_user.becomes User)
      return false
    end
    true
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
