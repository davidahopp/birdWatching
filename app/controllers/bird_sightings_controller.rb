class BirdSightingsController < ApplicationController

  def create

    sighting = BirdSighting.new(params[:bird_sighting])
    sighting.save

    respond_to do |format|
      format.json { render :json => sighting}
    end

  end

  def index

    sightings = BirdSighting.all

    respond_to do |format|
      format.json { render :json => sightings}
    end

  end

  def destroy

    sighting = BirdSighting.where(id: params[:id]).first
    sighting.destroy

    respond_to do |format|
      format.json { render :json => {success: true, data: nil, message: 'destroyed'}}
    end

  end

end
