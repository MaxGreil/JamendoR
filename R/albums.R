
getAlbum<-function(album_id=NULL, album_name=NULL) {
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

getAlbums<-function(album_ids) {
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

getAlbumTracks<-function(album_id=NULL, album_name=NULL) {
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

getAlbumMusicinfo<-function(album_id=NULL, album_name=NULL) {
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
    df <- setNames(data.frame(matrix(unlist(tags), nrow=length(tags[[1]]), byrow=T),stringsAsFactors=FALSE),"tags")
    return(df)
  }
}
