require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Gif Travel'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "drive-ruby-quickstart.yaml")
# SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY
# See: https://developers.google.com/identity/protocols/googlescopes
SCOPE = "https://www.googleapis.com/auth/drive.photos.readonly"

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
class DriveAPIWrapper
  attr_reader :file, :id, :created, :view, :download, :thumbnail, :mine, :width, :height, :size, :latitude, :longitude
  def initialize(aFile)
    @file = aFile.name
    @id = aFile.id
    @created = aFile.created_time
    @view = aFile.web_view_link
    @download = aFile.web_content_link
    @thumbnail = aFile.thumbnail_link
    @mine = aFile.owned_by_me
    @width = aFile.image_media_metadata.width
    @height = aFile.image_media_metadata.height
    @size = aFile.size
    if aFile.image_media_metadata.location != nil
      @latitude = aFile.image_media_metadata.location.latitude
      @longitude = aFile.image_media_metadata.location.longitude
    end
  end

  def self.authorize
    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " +
           "resulting code after authorization"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end


  def self.fetch
    # Initialize the API
    apiCall = Google::Apis::DriveV3::DriveService.new
    apiCall.client_options.application_name = APPLICATION_NAME
    apiCall.authorization = authorize
    # List the most recently modified GIF files.
    response = apiCall.list_files(page_size: 10,
                                  fields: 'nextPageToken, files(id, name, kind, mime_type)',
                                  q: "mimeType='image/gif'",
                                  spaces: 'photos'
                                  )

    puts 'No files found' if response.files.empty?
    puts 'showing off some code'
    response.files.map do |file|
      puts ""
      aFile = apiCall.get_file(file.id,
                                {fields: 'id, name, mimeType, thumbnailLink, webViewLink, webContentLink, createdTime, ownedByMe, size, imageMediaMetadata'}
                              )

      puts "File: #{aFile.name}"
      puts "ID: #{aFile.id}"
      puts "Created: #{aFile.created_time}"
      puts "View: #{aFile.web_view_link}"
      puts "Download: #{aFile.web_content_link}"
      puts "Thumbnail #{aFile.thumbnail_link}"
      puts "Mine: #{aFile.owned_by_me}"
      puts "Dimensions: #{aFile.image_media_metadata.width}x#{aFile.image_media_metadata.height}"
      puts "Size: #{aFile.size}bytes"
      if aFile.image_media_metadata.location != nil
        puts "Loc: #{aFile.image_media_metadata.location.latitude}, #{aFile.image_media_metadata.location.longitude}"
      else
        puts "Loc: 0, 0"
      end
      self.new(aFile)
    end
  end
end

#1 Save a copy of gif file (maybe via cUrl?) to gifs.travel server using webContentLink
  # Windows PowerShell example => Invoke-WebRequest 'https://drive.google.com/uc?id=0B2tqn9-EHK-ZU3ZOWmc1dHR6OFU&export=download' -OutFile test-ANIMATION.gif
#3 Write to an RSS file (XML) the properties of each new gif
  # read existing RSS file off server
  # parse RSS to get pubDate from channel > item[0]
  # convert pubDate to date
  # loop through 1000 most recent gifs with Drive.API call {note: that initially need to run through ALL results (not just top 1000)}
  # if gif.created_time > pubDate then add new item node to rss for each new gif with all metadata

  # IMPORTANT: Ignore all files if ownedByMe = false

#4 schedule job to run periodically
#5 build a web template XMLNS file to display HTML from RSS/XML file. Display 10 gifs per page.
# future features: user voting of gifs. social share links. UI to sort display based on ratings or most recent

## To-Test
# Make sure non-saved gifs don't get published
# Test ability to revoke certain select gifs (just delete from initial RSS?)
