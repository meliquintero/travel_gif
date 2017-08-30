require 'httparty'
require 'crack' # for xml and json
require 'crack/json' # for just json
require 'crack/xml' # for just xml

class PicasaAPIWrapper
  BASE_URL = "https://picasaweb.google.com/data/feed/api/user/"
  attr_reader :raw, :classOfData
  def initialize(data)
    @raw = data
    @classOfData = data.class
    #@food_id = data["suggestions"]["food_id"]
    # @music_id = data["suggestions"]["music_id"]
    # @music_type = data["suggestions"]["music_type"]
  end

  def self.fetch(user_uid)
    picasaData = HTTParty.get(BASE_URL + user_uid)
    #dataParsed = Crack::XML.parse(picasaData)
    return self.new(picasaData)
  end

end
