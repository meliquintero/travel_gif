require "#{Rails.root}/lib/PicasaAPIWrapper.rb"
require "#{Rails.root}/lib/DriveAPIWrapper.rb"

class TravelController < ApplicationController
  def index
    @arrayOfGifs = DriveAPIWrapper.fetch
  end

  def show
    @auth_hash = request.env['omniauth.auth']
    @picasa_data = PicasaAPIWrapper.fetch(@auth_hash["uid"])
  end
end
