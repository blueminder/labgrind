class ProjectUpdatesController < ApplicationController
  before_filter :require_user

  def create
    @project = Project.find(params[:project_id])
    @annotation = @project.project_updates.create(params[:project_update])
    redirect_to project_path(@project)
  end
  
end
