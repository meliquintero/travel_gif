puts {
  "kind" => "drive#file",
  "id" => "string",
  "etag": etag,
  "selfLink" => "string",
  "webContentLink" => "string",
  "webViewLink" => "string",
  "alternateLink" => "string",
  "embedLink" => "string",
  "openWithLinks": {
  },
  "defaultOpenWithLink" => "string",
  "iconLink" => "string",
  "hasThumbnail" => "boolean",
  "thumbnailLink" => "string",
  "thumbnailVersion" => "long",
  "thumbnail": {
    "image" => "bytes",
    "mimeType" => "string"
  },
  "title" => "string",
  "mimeType" => "string",
  "description" => "string",
  "labels": {
    "starred" => "boolean",
    "hidden" => "boolean",
    "trashed" => "boolean",
    "restricted" => "boolean",
    "viewed" => "boolean",
    "modified" => "boolean"
  },
  "createdDate": datetime,
  "modifiedDate": datetime,
  "modifiedByMeDate": datetime,
  "lastViewedByMeDate": datetime,
  "markedViewedByMeDate": datetime,
  "sharedWithMeDate": datetime,
  "version" => "long",
  "sharingUser": {
    "kind" => "drive#user",
    "displayName" => "string",
    "picture": {
      "url" => "string"
    },
    "isAuthenticatedUser" => "boolean",
    "permissionId" => "string",
    "emailAddress" => "string"
  },
  "parents": [
  ],
  "downloadUrl" => "string",
  "downloadUrl" => "string",
  "exportLinks": {
  },
  "indexableText": {
    "text" => "string"
  },
  "userPermission" => "permissions Resource",
  "permissions": [
  ],
  "hasAugmentedPermissions" => "boolean",
  "originalFilename" => "string",
  "fileExtension" => "string",
  "fullFileExtension" => "string",
  "md5Checksum" => "string",
  "fileSize" => "long",
  "quotaBytesUsed" => "long",
  "ownerNames": [
    "string"
  ],
  "owners": [
    {
      "kind" => "drive#user",
      "displayName" => "string",
      "picture": {
        "url" => "string"
      },
      "isAuthenticatedUser" => "boolean",
      "permissionId" => "string",
      "emailAddress" => "string"
    }
  ],
  "teamDriveId" => "string",
  "lastModifyingUserName" => "string",
  "lastModifyingUser": {
    "kind" => "drive#user",
    "displayName" => "string",
    "picture": {
      "url" => "string"
    },
    "isAuthenticatedUser" => "boolean",
    "permissionId" => "string",
    "emailAddress" => "string"
  },
  "ownedByMe" => "boolean",
  "capabilities": {
    "canAddChildren" => "boolean",
    "canChangeRestrictedDownload" => "boolean",
    "canComment" => "boolean",
    "canCopy" => "boolean",
    "canDelete" => "boolean",
    "canDownload" => "boolean",
    "canEdit" => "boolean",
    "canListChildren" => "boolean",
    "canMoveItemIntoTeamDrive" => "boolean",
    "canMoveTeamDriveItem" => "boolean",
    "canReadRevisions" => "boolean",
    "canReadTeamDrive" => "boolean",
    "canRemoveChildren" => "boolean",
    "canRename" => "boolean",
    "canShare" => "boolean",
    "canTrash" => "boolean",
    "canUntrash" => "boolean"
  },
  "editable" => "boolean",
  "canComment" => "boolean",
  "canReadRevisions" => "boolean",
  "shareable" => "boolean",
  "copyable" => "boolean",
  "writersCanShare" => "boolean",
  "shared" => "boolean",
  "explicitlyTrashed" => "boolean",
  "trashingUser": {
    "kind" => "drive#user",
    "displayName" => "string",
    "picture": {
      "url" => "string"
    },
    "isAuthenticatedUser" => "boolean",
    "permissionId" => "string",
    "emailAddress" => "string"
  },
  "trashedDate": datetime,
  "appDataContents" => "boolean",
  "headRevisionId" => "string",
  "properties": [
  ],
  "folderColorRgb" => "string",
  "imageMediaMetadata": {
    "width" => "integer",
    "height" => "integer",
    "rotation" => "integer",
    "location": {
      "latitude" => "double",
      "longitude" => "double",
      "altitude" => "double"
    },
    "date" => "string",
    "cameraMake" => "string",
    "cameraModel" => "string",
    "exposureTime" => "float",
    "aperture" => "float",
    "flashUsed" => "boolean",
    "focalLength" => "float",
    "isoSpeed" => "integer",
    "meteringMode" => "string",
    "sensor" => "string",
    "exposureMode" => "string",
    "colorSpace" => "string",
    "whiteBalance" => "string",
    "exposureBias" => "float",
    "maxApertureValue" => "float",
    "subjectDistance" => "integer",
    "lens" => "string"
  },
  "videoMediaMetadata": {
  },
  "spaces": [],
  "isAppAuthorized" => "boolean"
}.keys
