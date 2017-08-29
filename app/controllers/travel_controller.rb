class TravelController < ApplicationController
  def index
  end

  def show
    @auth_hash = request.env['omniauth.auth']
    print "auth_hash=====>", @auth_hash
  end
end
