require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Gif Travel'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, ENV["MY_CREDENTIALS_PATH"],
                             "drive-ruby-chongo_project.yaml")
# SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY
# See: https://developers.google.com/identity/protocols/googlescopes
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_PHOTOS_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
class PopulateDataBase
  def self.create(aFile)
    puts "creating new Gif in db"
    @gif = Gif.new
    @gif.name = aFile.name
    @gif.google_id = aFile.id
    @gif.created_time = aFile.created_time
    @gif.web_view_link = aFile.web_view_link
    @gif.web_content_link = aFile.web_content_link
    @gif.thumbnail_link = aFile.thumbnail_link
    @gif.owned_by_me = aFile.owned_by_me
    @gif.width = aFile.image_media_metadata.width
    @gif.height = aFile.image_media_metadata.height
    @gif.size = aFile.size
    if aFile.image_media_metadata.location != nil
      @gif.latitude = aFile.image_media_metadata.location.latitude
      @gif.longitude = aFile.image_media_metadata.location.longitude
    end

    @gif.save

    if @gif.save
      puts "#{@gif.google_id} saved succesfully in DB"
    else
      puts "#{@gif.google_id} failed to be added in the data base"
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


  def self.populate_db_1000
    # Initialize the API
    apiCall = Google::Apis::DriveV3::DriveService.new
    apiCall.client_options.application_name = APPLICATION_NAME
    apiCall.authorization = authorize
    # List the most recently modified GIF files.
    response = apiCall.list_files(page_size: 5,
                                  fields: 'nextPageToken, files(id, name, kind, mime_type, thumbnailLink, webViewLink, webContentLink, createdTime, ownedByMe, size, imageMediaMetadata)',
                                  q: "mimeType='image/gif'",
                                  spaces: 'photos'
                                  )

    puts 'No files found' if response.files.empty?

    response.files.map do |aFile|
      puts "aFile====> ", aFile.inspect
      @gif ||= Gif.find_by(google_id: aFile.id)
      if @gif.nil?
        @gif = self.create(aFile)
      end
    end
  end
end
