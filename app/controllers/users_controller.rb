# The controller that handles user-related actions.
class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]

  # Returns all skills
  def get_all_skills
    @skills = Skill.find(:all)
  end
  
  # Returns all projects
  def get_all_projects
    @projects = Project.find(:all)
  end

  # Shows a list of all users.
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # Shows the page for a single user
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # Shows the page to register a new user.
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # Makes edits to the user.
  def edit
    get_all_skills
    get_all_projects
    @user = User.find_by_username(params[:id])
    return false unless require_specific_user(@user)
  end

  # Actually creates a new user. Note that this is also the method that will be
  # called upon commiting the initial configuration page.
  def create
	if User.count == 0 and params[:make_admin]
		# Make a new admin if and only if no other users
		@user = Admin.new(params[:user])
	else
	    @user = User.new(params[:user])
	end
    get_all_skills
    get_all_projects

    respond_to do |format|
      if @user.save
		if params[:make_admin]
		  # Admins will get redirected to the labs_url to make more stuff
		  format.html { redirect_to('/labs',
			:notice => 'Initial configuration succesful, please make labs.') }
		else
          format.html { redirect_to(:users, :notice => 'Registration successful.') }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
		end
	  elsif params[:make_admin]
		  format.html { render "user_sessions/init_config" }
	  else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Commits an update to a new user.
  def update
    @user = User.find_by_username(params[:id])

    return false unless require_specific_user(@user)

    get_all_skills
    get_all_projects

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user.becomes(User), :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a new user. This action is only permissible by the user itself or
  # by a superadmin.
  def destroy
    @user = User.find_by_username(params[:id])

    return false unless require_specific_user(@user)

    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # Converts a user into a lab admin
  def adminify
    return false unless require_super_admin

    user = User.find(params[:user_id])
    lab = Lab.find(params[:lab_id])
    user.class_type = "LabAdmin"
    user.save
    user = user.becomes LabAdmin
    user.lab = lab
    user.save

    redirect_to(user.becomes User)
  end

  # Converts a user into a super-admin
  def superadminify
    return false unless require_super_admin

    user = User.find(params[:user_id])
    user.class_type = "Admin"
    user.save

    redirect_to(user.becomes User)
  end

  # Converts a user into a plain ol' user.
  def deadminify
    return false unless require_super_admin

    user = User.find(params[:user_id])
    user.class_type = "User"
    user.save

    redirect_to(user.becomes User)
  end
end
