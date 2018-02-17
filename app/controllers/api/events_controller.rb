class Api::EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event
    else
      flash.now[:alert] = 'Please fill out entire form.'
    end
  end

  private
  def event_params
    params.require(:event).permit(
      :name, :date, :time, :address, :details, :summary, :organizer)
  end
end
