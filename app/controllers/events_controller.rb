class EventsController < ApplicationController
  def index
    # Traemos todos los eventos ordenados por fecha de inicio
    @events = Event.order(start_date: :asc)
  end
end