#' @title Search Jamendo database for an artist
#' @description Search Jamendo database for an artist. You can search for either an artist ID or an artist name.
#' @param artist_id Artist ID to seach for
#' @param artist_name Artist name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about an artist.
#' See \url{https://developer.jamendo.com/v3.0/artists} for more information.
#' @examples \donttest{
#' ##Example
#'  artistID <- getArtist(artist_id="1510")
#'  artistName <- getArtist(artist_name="Judas Priestley")
#' }
#' @export

getArtist<-function(artist_id=NULL, artist_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(artist_id,artist_name)
  url <- 'https://api.jamendo.com/v3.0/artists/'
  if(is.null(artist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = artist_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = artist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","website","joindate","shorturl","shareurl")]
    return(df)
  }
}

#' Search Jamendo database for several artists
#' @param artist_ids List of artist IDs to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about several albums.
#' See \url{https://developer.jamendo.com/v3.0/artists} for more information.
#' @examples \donttest{
#' ##Example
#'  IDs <- c(1510,338873)
#'  artists <- getArtists(IDs)
#' }
#' @export

getArtists<-function(artist_ids, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/artists/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                id = paste(artist_ids,collapse = '+'))
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","website","joindate","shorturl","shareurl")]
    return(df)
  }
}

#' @title Get tracks from an artist
#' @description Search Jamendo database for an artist. You can search for either an artist ID or an artist name.
#' @param artist_id Artist ID to seach for
#' @param artist_name Artist name to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about tracks from an artist.
#' See \url{https://developer.jamendo.com/v3.0/artists/tracks} for more information.
#' @examples \donttest{
#' ##Example
#'  tracksFromID <- getArtistTracks(artist_id="1510",limit=3)
#'  tracksFromName <- getArtistTracks(artist_name="Judas Priestley",limit=3)
#' }
#' @export

getArtistTracks<-function(artist_id=NULL, artist_name=NULL, limit = 10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(artist_id,artist_name)
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/artists/tracks/'
  if(is.null(artist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = artist_name,
                  limit = limit)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = artist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$tracks[[1]]
    return(df)
  }
}

#' @title Get albums from an artist
#' @description Search Jamendo database for an artist. You can search for either an artist ID or an artist name.
#' @param artist_id Artist ID to seach for
#' @param artist_name Artist name to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about albums from an artist.
#' See \url{https://developer.jamendo.com/v3.0/artists/albums} for more information.
#' @examples \donttest{
#' ##Example
#'  albumsFromID <- getArtistAlbums(artist_id="1510",limit=3)
#'  albumsFromName <- getArtistAlbums(artist_name="Judas Priestley",limit=3)
#' }
#' @export

getArtistAlbums<-function(artist_id=NULL, artist_name=NULL, limit = 10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(artist_id,artist_name)
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/artists/albums/'
  if(is.null(artist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = artist_name,
                  limit = limit)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = artist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$albums[[1]]
    return(df)
  }
}

#' This method let you select and filter geographical locations which artists have declared as reference for themselves
#' @param location The artist country (following ISO 3166_1 standard \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3#Officially_assigned_code_elements})
#' @param city The artist city (optional)
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about artist from a certain location.
#' See \url{https://developer.jamendo.com/v3.0/artists/locations} for more information.
#' @examples \donttest{
#' ##Example
#'  artists <- getArtistsLocation("GRC", limit=3)
#' }
#' @export

getArtistsLocation<-function(location, city=NULL, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/artists/locations/'
  if(is.null(city)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  limit = limit,
                  location_country = location)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  limit = limit,
                  location_country = location,
                  location_city = city)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","website","joindate","shorturl","shareurl")]
    return(df)
  }
}

#' @title Get tag list of an artist
#' @description Get tag list of an artist. You can search for either an artist ID or an artist name.
#' @param artist_id Artist ID to seach for
#' @param artist_name Artist name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains tag list of an artist.
#' See \url{https://developer.jamendo.com/v3.0/artists/musicinfo} for more information.
#' @examples \donttest{
#' ##Example
#'  tagsFromID <- getArtistMusicinfo(artist_id="1510")
#'  tagsFromName <- getArtistMusicinfo(artist_name="Judas Priestley")
#' }
#' @export

getArtistMusicinfo<-function(artist_id=NULL, artist_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(artist_id,artist_name)
  url <- 'https://api.jamendo.com/v3.0/artists/musicinfo/'
  if(is.null(artist_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = artist_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = artist_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    tags<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$musicinfo[[1]]
    df <- stats::setNames(data.frame(matrix(unlist(tags), nrow=length(tags[[1]]), byrow=T),stringsAsFactors=FALSE),"tags")
    return(df)
  }
}
