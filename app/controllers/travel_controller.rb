require "#{Rails.root}/lib/DriveAPIWrapper.rb"

class TravelController < ApplicationController
  def index
    @arrayOfGifs = DriveAPIWrapper.fetch
  end

end
