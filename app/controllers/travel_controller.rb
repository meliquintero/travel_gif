require "#{Rails.root}/lib/DriveAPIWrapper.rb"

class TravelController < ApplicationController
  def index
    @m = PopulateDataBase.populate_db_1000
    @arrayOfGifs = Gif.last(5)
  end

end
