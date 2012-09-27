class BirdSightingsController < ApplicationController

  def create

    puts params

    render :text => "created"

  end

  def index

    puts "SHOWING all"

    render :text => "here they are"

  end

end
