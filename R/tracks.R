#' @title Search Jamendo database for a track
#' @description Search Jamendo database for a track. You can search for either a track ID or a track name.
#' @param track_id Track ID to seach for
#' @param track_name Track name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a track.
#' See \url{https://developer.jamendo.com/v3.0/tracks} for more information.
#' @examples \dontrun{
#' ##Examples
#'  trackID <- getTrack(track_id="114069")
#'  trackName <- getTrack(track_name="Deuteranopia 0")
#' }
#' @export

getTrack<-function(track_id=NULL, track_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(track_id,track_name)
  url <- 'https://api.jamendo.com/v3.0/tracks/'
  if(is.null(track_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = track_name,
                  include = 'lyrics')
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = track_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","duration","artist_id","artist_name","album_name","album_id",
                "license_ccurl","position","releasedate","audio","audiodownload",
                "prourl","shorturl","shareurl")]
    return(df)
  }
}

#' Search Jamendo database for several tracks
#' @param track_ids List of track IDs to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about several tracks.
#' See \url{https://developer.jamendo.com/v3.0/tracks} for more information.
#' @examples \dontrun{
#' ##Examples
#'  IDs <- c(114069,113885)
#'  tracks <- getTracks(IDs)
#' }
#' @export

getTracks<-function(track_ids, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                id = paste(track_ids,collapse = '+'))
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","duration","artist_id","artist_name","album_name","album_id",
                "license_ccurl","position","releasedate","audio","audiodownload",
                "prourl","shorturl","shareurl")]
    return(df)
  }
}

#' @title Search Jamendo database for a track
#' @description Search by one or more tags (genre, instrument, theme and nc tags).
#' @param tags Tags to seach for (genre, instrument, theme and nc tags)
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a track.
#' See \url{https://developer.jamendo.com/v3.0/tracks} for more information.
#' @export

getTracksTags<-function(tags, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                tags = paste(tags,collapse = '+'),
                limit=limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","duration","artist_id","artist_name","album_name","album_id",
                "license_ccurl","position","releasedate","audio","audiodownload",
                "prourl","shorturl","shareurl")]
    return(df)
  }
}

#' @title Search Jamendo database for a track
#' @description Search Jamendo database for a track by name with namesearch.
#' @param namesearch Search a track by name
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a track.
#' See \url{https://developer.jamendo.com/v3.0/tracks} for more information.
#' @export

getTracksNamesearch<-function(namesearch, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                namesearch = namesearch,
                limit=limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","duration","artist_id","artist_name","album_name","album_id",
                "license_ccurl","position","releasedate","audio","audiodownload",
                "prourl","shorturl","shareurl")]
    return(df)
  }
}


#' @title Search Jamendo database for a track
#' @description Given the id of a Jamendo track, this function lets you find other similar Jamendo tracks.
#' @param track_id Track ID to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a track.
#' See \url{https://developer.jamendo.com/v3.0/tracks} for more information.
#' @export

getTracksSimilar<-function(track_id, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/tracks/similar/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                id = track_id,
                limit=limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","duration","artist_id","artist_name","album_name","album_id",
                "license_ccurl","position","releasedate","audio","audiodownload",
                "prourl","shorturl","shareurl")]
    return(df)
  }
}
