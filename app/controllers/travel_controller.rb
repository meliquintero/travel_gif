require "#{Rails.root}/lib/PicasaAPIWrapper.rb"

class TravelController < ApplicationController
  def index
  end

  def show
    @auth_hash = request.env['omniauth.auth']
    @picasa_data = PicasaAPIWrapper.fetch(@auth_hash["uid"])
  end
end
