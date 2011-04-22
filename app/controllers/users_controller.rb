# The controller that handles user-related actions.
class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]

  def get_all_skills
    @skills = Skill.find(:all)
  end
  
  def get_all_projects
    @projects = Project.find(:all)
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    get_all_skills
    get_all_projects
    @user = User.find_by_username(params[:id])
  end

  # POST /users
  # POST /users.xml
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
        format.html { redirect_to(:users, :notice => 'Registration successful.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
	  elsif params[:make_admin]
		  # Admins will get redirected to the labs_url to make more stuff
		  format.html { render labs_url }
	  else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_by_username(params[:id])
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

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_username(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end

  end
end
