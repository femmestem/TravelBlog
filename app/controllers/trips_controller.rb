class TripsController < ApplicationController

  def index
    @trips = Trip.all
    @trip = Trip.new
  end

  def new
    redirect_to root_path unless logged_in?
    @trip = Trip.new
  end

  def create
    location = params[:location]

    @trip = current_user.trips.create(title: location)

    render json: { trip_title: location, trip_id: @trip.id }.to_json
  end

  def show
    @coords = []

    @trip = Trip.find(params[:id])
    @locationpins = @trip.location_pins

  end

  def show_markers
    marker = []
    locationpins = Trip.find(params[:id]).location_pins

    locationpins.each do |locationpin|
      locationpin.posts.each do |post|
        marker << { coords: locationpin.coords, posts: {title: post.title, body: post.body} }
      end

    end
    render json: { marker: marker }.to_json
  end

  private

  def trip_params
    @trip.require(:trip).permit(:title)
  end


end
