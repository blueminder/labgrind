# The controller that handles all lab actions.
class LabsController < ApplicationController
  before_filter :require_user

  # Shows the page that lists all labs.
  def index
    @labs = Lab.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @labs }
    end
  end

  # Shows the page for a single lab.
  def show
    @lab = Lab.find(params[:id])

    @events = Event.where(:lab_id => @lab.id)

    @month = (params[:month] || Time.zone.now.month).to_i
    @year = (params[:year] || Time.zone.now.year).to_i

    @shown_month = Date.civil(@year, @month)
    start_d, end_d = Event.get_start_and_end_dates(@shown_month)

    @event_strips = Event.create_event_strips(start_d, end_d, @events)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lab }
    end
  end

  # Shows the page that creates a new lab
  def new
    return false unless require_super_admin

    @lab = Lab.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lab }
    end
  end

  # Shows the page that allows editing of a lab
  def edit
    @lab = Lab.find(params[:id])

    return false unless require_lab_admin(@lab)
  end

  # Creates a new lab.
  def create
    @lab = Lab.new(params[:lab])

    return false unless require_lab_admin(@lab)

    respond_to do |format|
      if @lab.save
        format.html { redirect_to(@lab, :notice => 'Lab was successfully created.') }
        format.xml  { render :xml => @lab, :status => :created, :location => @lab }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lab.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates the lab
  def update
    @lab = Lab.find(params[:id])

    return false unless require_lab_admin(@lab)

    respond_to do |format|
      if @lab.update_attributes(params[:lab])
        format.html { redirect_to(@lab, :notice => 'Lab was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lab.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a lab.
  def destroy
    @lab = Lab.find(params[:id])
    
    return false unless require_lab_admin(@lab)

    @lab.destroy

    respond_to do |format|
      format.html { redirect_to(labs_url) }
      format.xml  { head :ok }
    end
  end
end
