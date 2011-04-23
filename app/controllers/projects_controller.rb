# The controller for projects.
class ProjectsController < ApplicationController
  before_filter :require_user
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @owners = ProjectAssignment.find(:all, :conditions => { :project_id => @project.id, :owner => 1 })

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])

    return false unless require_project_owner(@project)

    @users = User.all
    @owners = ProjectAssignment.find(:all, :conditions => { :project_id => @project.id, :owner => 1 })
    @passed_owners = params[:owners]
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.users << current_user
    
    respond_to do |format|
      if @project.save
        @project.add_owner(current_user)

        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    return false unless require_project_owner(@project)

    respond_to do |format|
      if @project.update_attributes(params[:project])
        @passed_users = params[:all_users] 
        @passed_members = params[:members]
        @passed_owners = params[:owners]
        
        p_users_array = @project.users.map { |user| [user.username, user.id] }
        
        if !@passed_users.nil?
          @passed_users.each do |user|
            if @project.users.include?(User.find(user.to_i))
              @project.users.delete(User.find(user.to_i))
            end
            
            if @project.owners.include?(User.find(user.to_i))
              @project.remove_owner(User.find(user.to_i))
            end
          end
        end
        
        if !@passed_members.nil?
          @passed_members.each do |member|
            if !@project.users.include?(User.find(member.to_i))
              @project.users << User.find(member.to_i)
            end
            
            if @project.owners.include?(User.find(member.to_i))
              @project.remove_owner(User.find(member.to_i))
            end
          end
        end
        
        if !@passed_owners.nil?
          @passed_owners.each do |owner|
            if !@project.users.include?(User.find(owner.to_i))
              @project.users << User.find(owner.to_i)
            end
            
            if !@project.owners.include?(User.find(owner.to_i))
              @project.add_owner(User.find(owner.to_i))
            end
          end
        end
        
        format.html { redirect_to(@project, :notice => 'Project successfully updated') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])

    return false unless require_project_owner(@project)

    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
