#' @title Search Jamendo database for an album
#' @description Search Jamendo database for an album. You can search for either an album ID or an album name.
#' @param album_id Album ID to seach for
#' @param album_name Album name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about an album.
#' See \url{https://developer.jamendo.com/v3.0/albums} for more information.
#' @examples \dontrun{
#' ##Example
#'  albumID <- getAlbum(album_id = "14866")
#'  albumName <- getAlbum(album_name = "Deuteranopia Utopia")
#' }
#' @export

getAlbum<-function(album_id=NULL, album_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(album_id,album_name)
  url <- 'https://api.jamendo.com/v3.0/albums/'
  if(is.null(album_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = album_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = album_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","releasedate","artist_id",
                "artist_name","zip","shorturl","shareurl")]
    return(df)
  }
}

#' Search Jamendo database for several albums
#' @param album_ids List of album IDs to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about several albums.
#' See \url{https://developer.jamendo.com/v3.0/albums} for more information.
#' @examples \dontrun{
#' ##Example
#'  IDs <- c(104336,124067)
#'  albums <- getAlbums(IDs)
#' }
#' @export

getAlbums<-function(album_ids, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  url <- 'https://api.jamendo.com/v3.0/albums/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                id = paste(album_ids,collapse = '+'))
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","releasedate","artist_id",
                "artist_name","zip","shorturl","shareurl")]
    return(df)
  }
}

#' @title Get tracks from an album
#' @description Get tracks from an album. You can search for either an album ID or an album name.
#' @param album_id Album ID to seach for
#' @param album_name Album name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about tracks from an album.
#' See \url{https://developer.jamendo.com/v3.0/albums/tracks} for more information.
#' @export

getAlbumTracks<-function(album_id=NULL, album_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(album_id,album_name)
  url <- 'https://api.jamendo.com/v3.0/albums/tracks/'
  if(is.null(album_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = album_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = album_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    df<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$tracks[[1]]
    return(df)
  }
}

#' @title Get tag list of an album
#' @description Get tag list of an album. You can search for either an album ID or an album name.
#' @param album_id Album ID to seach for
#' @param album_name Album name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains tag list of an album.
#' See \url{https://developer.jamendo.com/v3.0/albums/musicinfo} for more information.
#' @export

getAlbumMusicinfo<-function(album_id=NULL, album_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(album_id,album_name)
  url <- 'https://api.jamendo.com/v3.0/albums/musicinfo/'
  if(is.null(album_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = album_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = album_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    tags<-jsonlite::fromJSON(jsonlite::toJSON(res))$results$musicinfo[[1]]
    df <- stats::setNames(data.frame(matrix(unlist(tags), nrow=length(tags[[1]]), byrow=T),stringsAsFactors=FALSE),"tags")
    return(df)
  }
}
