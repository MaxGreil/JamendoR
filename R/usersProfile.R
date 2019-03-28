#' @title Search Jamendo database for a user
#' @description Search Jamendo database for a user. You can search for either a user ID or a user name.
#' @param user_id User ID to seach for
#' @param user_name User name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a user.
#' See \url{https://developer.jamendo.com/v3.0/users} for more information.
#' @export

getUserProfile<-function(user_id = NULL, user_name = NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')){
  controlInputVariables(user_id,user_name)
  url <- 'https://api.jamendo.com/v3.0/users/'
  if(is.null(user_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = user_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = user_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","dispname","lang","creationdate")]
    return(df)
  }
}

#' Get information about your user profile
#' @param token Your OAuth access token
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about your user profile.
#' See \url{https://developer.jamendo.com/v3.0/users} for more information.
#' @export

getMyUserProfile<-function(token, client_id = Sys.getenv('JAMENDO_CLIENT_ID')){
  url <- 'https://api.jamendo.com/v3.0/users/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                access_token = token$credentials$access_token)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(res$headers$code == 12) {
    stop("Access token has expired. Use function refreshToken(token) to obtain a new access token.")
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","dispname","lang","creationdate")]
    return(df)
  }
}

#' @title Get artists a user is a fan of
#' @description Get artists a user is a fan of. You can search for either a user ID or a user name.
#' @param user_id User ID to seach for
#' @param user_name User name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains artists a user is a fan of.
#' See \url{https://developer.jamendo.com/v3.0/users/artists} for more information.
#' @export

getUserProfileArtists<-function(user_id = NULL, user_name = NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(user_id,user_name)
  url <- 'https://api.jamendo.com/v3.0/users/artists/'
  if(is.null(user_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = user_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = user_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$artists[[1]]
    return(df)
  }
}

#' @title Get albums a user added to myalbums
#' @description Get albums added to myalbums. You can search for either a user ID or a user name.
#' @param user_id User ID to seach for
#' @param user_name User name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains albums a user added to myalbums.
#' See \url{https://developer.jamendo.com/v3.0/users/albums} for more information.
#' @export

getUserProfileAlbums<-function(user_id = NULL, user_name = NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(user_id,user_name)
  url <- 'https://api.jamendo.com/v3.0/users/albums/'
  if(is.null(user_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = user_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = user_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$albums[[1]]
    return(df)
  }
}

#' Get tracks a user has liked, added to favorite or reviewed
#' @param user_id User ID to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains tracks a user has liked, added to favorite or reviewed.
#' See \url{https://developer.jamendo.com/v3.0/users/tracks} for more information.
#' @export

getUserProfileTracks<-function(user_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/users/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                id = user_id)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$tracks[[1]]
    return(df)
  }
}

#' Become a fan of an artist
#' @param token Your OAuth access token
#' @param artist_id Artist ID of artist you want to become a fan of
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' See \url{https://developer.jamendo.com/v3.0/setuser/fan} for more information.
#' @export

setUserFan<-function(token,artist_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/setuser/fan/'
  body <- list(client_id = client_id,
               format="jsonpretty",
               access_token= token$credentials$access_token,
               artist_id=artist_id)
  t <- httr::RETRY('POST', url, httr::accept_json(), body = body)
  post <- httr::content(t, "parsed",encoding = "UTF-8")
  parseResponse(post)
}

#' Add a given track to your preferites
#' @param token Your OAuth access token
#' @param track_id Track ID of track you want to favourite
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' See \url{https://developer.jamendo.com/v3.0/setuser/favourite} for more information.
#' @export

setUserFavorite<-function(token, track_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/setuser/favorite/'
  body <- list(client_id = client_id,
               format="jsonpretty",
               access_token= token$credentials$access_token,
               track_id=track_id)
  t <- httr::RETRY('POST', url, httr::accept_json(), body = body)
  post <- httr::content(t, "parsed",encoding = "UTF-8")
  parseResponse(post)
}

#' Like the track given by Track ID
#' @param token Your OAuth access token
#' @param track_id Track ID of track you want to like
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' See \url{https://developer.jamendo.com/v3.0/setuser/like} for more information.
#' @export

setUserLike<-function(token, track_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/setuser/like/'
  body <- list(client_id = client_id,
               format="jsonpretty",
               access_token= token$credentials$access_token,
               track_id=track_id)
  t <- httr::RETRY('POST', url, httr::accept_json(), body = body)
  post <- httr::content(t, "parsed",encoding = "UTF-8")
  parseResponse(post)
}

#' Dislike the track given by Track ID
#' @param token Your OAuth access token
#' @param track_id Track ID of rtrack you want to dislike
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' See \url{https://developer.jamendo.com/v3.0/setuser/dislike} for more information.
#' @export

setUserDislike<-function(token, track_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/setuser/dislike/'
  body <- list(client_id = client_id,
               format="jsonpretty",
               access_token= token$credentials$access_token,
               track_id=track_id)
  t <- httr::RETRY('POST', url, httr::accept_json(), body = body)
  post <- httr::content(t, "parsed",encoding = "UTF-8")
  parseResponse(post)
}

#' Add album to your list of favorite albums myalbums
#' @param token Your OAuth access token
#' @param album_id Album ID of album you want to add to list myalbums
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' See \url{https://developer.jamendo.com/v3.0/setuser/myalbum} for more information.
#' @export

setUserMyalbum<-function(token, album_id, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/setuser/myalbum/'
  body <- list(client_id = client_id,
               format="jsonpretty",
               access_token= token$credentials$access_token,
               album_id=album_id)
  t <- httr::RETRY('POST', url, httr::accept_json(), body = body)
  post <- httr::content(t, "parsed",encoding = "UTF-8")
  parseResponse(post)
}
