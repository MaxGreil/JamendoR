#' @title Search Jamendo database for a playlist
#' @description Search Jamendo database for a playlist. You can search for either a playlist ID or a playlist name.
#' @param playlist_id Playlist ID to seach for
#' @param playlist_name Playlist name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a playlist.
#' See \url{https://developer.jamendo.com/v3.0/playlists} for more information.
#' @export

getPlaylist<-function(playlist_id=NULL, playlist_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(playlist_id,playlist_name)
  url <- 'https://api.jamendo.com/v3.0/playlists/'
  if(is.null(playlist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = playlist_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = playlist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","creationdate","user_id",
                "user_name","zip","shorturl","shareurl")]
    return(df)
  }
}

#' Search Jamendo database for playlists
#' @param namesearch String to search for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a playlists.
#' See \url{https://developer.jamendo.com/v3.0/playlists} for more information.
#' @export

getPlaylistsNamesearch<-function(namesearch, limit = 10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')){
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/playlists/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                namesearch = namesearch,
                limit = limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","creationdate","user_id",
                "user_name","zip","shorturl","shareurl")]
    return(df)
  }
}

#' Get your own playlists
#' @param token OAuth access token (the previously created OAuth token)
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about your playlists.
#' See \url{https://developer.jamendo.com/v3.0/playlists} for more information.
#' @export

getMyPlaylists<-function(token, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/playlists/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                access_token = token$credentials$access_token)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(res$headers$code == 12) {
    stop("Access token has expired. Use function refreshToken(token) to obtain a new access token.")
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","creationdate","user_id",
                "user_name","zip","shorturl","shareurl")]
    return(df)
  }
}

#' @title Get all tracks from a playlist
#' @description Get all tracks from a playlist. You can search for either a playlist ID or a playlist name.
#' @param playlist_id Playlist ID to seach for
#' @param playlist_name Playlist name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about all tracks from a playlist.
#' See \url{https://developer.jamendo.com/v3.0/playlists/tracks} for more information.
#' @export

getPlaylistTracks<-function(playlist_id=NULL, playlist_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(playlist_id,playlist_name)
  url <- 'https://api.jamendo.com/v3.0/playlists/tracks/'
  if(is.null(playlist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = playlist_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = playlist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$tracks[[1]]
    return(df)
  }
}
