class Api::EventsController < ApplicationController

  @@queued_events = []

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      Event.queue.push(@event)
      redirect_to root_url
    else
      alert("bad info")
      # render json: @event, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def event_params
    params.require(:event).permit(
      :name, :date, :time, :address, :details, :summary, :organizer)
  end
end
