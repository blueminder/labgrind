# The controller that handles calendar events.
class EventsController < ApplicationController
  before_filter :require_user

  # Gets a list of all events
  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.xml
    end
  end

  # Shows a single event
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.xml
    end
  end

  # Makes a new event
  def new
    @event = Event.new

    respond_to do |format|
      format.html
      format.xml
    end
  end

  # Displays the edit page
  def edit
    @event = Event.find(params[:id])
    if @event.project
      return false unless require_project_owner(@event.project)
    else
      return false unless require_lab_admin(@event.lab)
    end
  end

  # Commits the changes to a new event
  def create
    @event = Event.new(params[:event])
    if @event.project then
      return false unless require_project_owner(@event.project)
    else
      return false unless require_lab_admin(@event.lab)
    end

    respond_to do |format|
      if @event.save then
        format.html {redirect_to(@event, :notice => "Event created")}
        format.xml  { render :xml => @event, :status => :created, \
          :location => @event }
        else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, \
          :status => :unprocessable_entity }
      end
    end
  end

  # Commits the change to an updated event
  def update
    @event = Event.find(params[:id])

    if @event.project then
      return false unless require_project_owner(@event.project)
    else
      return false unless require_lab_admin(@event.lab)
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, \
          :status => :unprocessable_entity }
      end
    end
  end

  # Deletes the event.
  def destroy
    @event = Event.find(params[:id])

    if @event.project then
      return false unless require_project_owner(@event.project)
    else
      return false unless require_lab_admin(@event.lab)
    end

    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
