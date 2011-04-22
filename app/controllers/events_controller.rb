# The controller that handles calendar events.
class EventsController < ApplicationController
  before_filter :require_user

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def edit
    @event = Event.find(params[:id])
    if @event.project
      require_project_owner(@event.project)
    else
      require_lab_admin(@event.lab)
    end
  end

  def create
    @event = Event.new(params[:event])
    if @event.project then
      require_project_owner(@event.project)
    else
      require_lab_admin(@event.lab)
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

  def update
    @event = Event.find(params[:id])

    if @event.project then
      require_project_owner(@event.project)
    else
      require_lab_admin(@event.lab)
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

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    if @event.project then
      require_project_owner(@event.project)
    else
      require_lab_admin(@event.lab)
    end

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
