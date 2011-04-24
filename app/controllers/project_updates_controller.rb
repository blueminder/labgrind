# This is the controller to manage updates to projects by users.
class ProjectUpdatesController < ApplicationController
  before_filter :require_user

  # Creates a new update to a project
  def create
    @project = Project.find(params[:project_id])
    @annotation = @project.project_updates.create(params[:project_update])
    redirect_to project_path(@project)
  end

  # Commits an update to the project
  def update
    @project = Project.find(params[:project_id])
    @update = @project.project_updates.find(params[:id])
    @update.content = params[:value]
    @update.save
    render :text => params[:value]
  end
  
  # DELETE /projects/1/project_updates/1
  # DELETE /projects/1/project_updates/1.xml
  def destroy
    @project = Project.find(params[:project_id])
    @update = @project.project_updates.find( params[:id] )
    @update.destroy
    flash[:notice] = 'Entry removed.'
    redirect_to(@project)
  end

  
end
