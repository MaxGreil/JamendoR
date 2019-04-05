#' This method lets you filter and browse album reviews
#' @param album_ids List of album IDs to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains reviews of the searched albums.
#' See \url{https://developer.jamendo.com/v3.0/reviews/albums} for more information.
#' @examples \dontrun{
#' ##Example
#'  IDs <- c(104336,124067)
#'  reviews <- getReviewsAlbums(IDs)
#' }
#' @export

getReviewsAlbums<-function(album_ids, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/reviews/albums/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                album_id =  paste(album_ids,collapse = '+'),
                limit= limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","title","text","dateadded","agreecnt","lang","user_id",
                "user_name","user_dispname","score","album_id","album_name","artist_id")]
    return(df)
  }
}

#' This method lets you filter and browse album reviews for a specific artist
#' @param artist_id Artist ID to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains reviews of the searched albums for a specific artist.
#' See \url{https://developer.jamendo.com/v3.0/reviews/albums} for more information.
#' @export

getReviewsArtistAlbums<-function(artist_id, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/reviews/albums/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                artist_id = artist_id,
                limit = limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","title","text","dateadded","agreecnt","lang","user_id",
                "user_name","user_dispname","score","album_id","album_name","artist_id")]
    return(df)
  }
}

#' This method lets you filter and browse album reviews from a specific user
#' @param user_id User ID to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains reviews of the searched albums from a specific user.
#' See \url{https://developer.jamendo.com/v3.0/reviews/albums} for more information.
#' @export

getReviewsAlbumsUser<-function(user_id, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/reviews/albums/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                user_id =  user_id,
                limit= limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","title","text","dateadded","agreecnt","lang","user_id",
                "user_name","user_dispname","score","album_id","album_name","artist_id")]
    return(df)
  }
}

#' This method lets you filter and browse track reviews
#' @param track_ids List of album IDs to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains track reviews of the searched albums.
#' See \url{https://developer.jamendo.com/v3.0/reviews/tracks} for more information.
#' @export

getReviewsTracks<-function(track_ids, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/reviews/tracks/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                track_id =  paste(track_ids,collapse = '+'),
                limit= limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","title","text","dateadded","agreecnt","lang","user_id","user_name",
                "user_dispname","score","track_id","track_name","album_id","artist_id",
                "track_license_ccurl","track_audio","track_audiodownload")]
    return(df)
  }
}
