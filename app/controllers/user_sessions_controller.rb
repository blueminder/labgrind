# This controller manages user sessions.
class UserSessionsController < ApplicationController  
	before_filter :require_no_user, :except => [:create, :destroy]

  # This is also what you are redirected to if you have yet to log in.
  # There is also code here for dealing with the case where the server has yet
  # to have any accounts
  def new
	if User.count == 0
	  @user = Admin.new
	  render :init_config
	  return
	end
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  # Handles login of a user.
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to(user_path(current_user), :notice => 'You have successfully logged in.') }
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end  

  # Handles logout of a user.
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(:users, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end
end
