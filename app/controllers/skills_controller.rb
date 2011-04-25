# This controller handles skill-related administrative actions.
class SkillsController < ApplicationController
  before_filter :require_admin

  # Shows the list of skills
  def index
    @skills = Skill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @skills }
    end
  end

  # Shows the page for an individual skill
  def show
    @skill = Skill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @skill }
    end
  end

  # Shows the page to make a new skill
  def new
    @skill = Skill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @skill }
    end
  end

  # Shows the page to edit a new skill
  def edit
    @skill = Skill.find(params[:id])
  end

  # Commits the creation of a new skill.
  def create
    @skill = Skill.new(params[:skill])

    respond_to do |format|
      if @skill.save
        format.html { redirect_to(@skill, :notice => 'Skill was successfully created.') }
        format.xml  { render :xml => @skill, :status => :created, :location => @skill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Commits an update of a skill page.
  def update
    @skill = Skill.find(params[:id])

    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        format.html { redirect_to(@skill, :notice => 'Skill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a skill for real.
  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to(skills_url) }
      format.xml  { head :ok }
    end
  end
end
