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
  end

  def self.fetch(user_uid)
    picasaData = HTTParty.get(BASE_URL + user_uid)
    #dataParsed = Crack::XML.parse(picasaData)
    return self.new(picasaData)
  end

end
