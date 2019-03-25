#' This method returns the editorial feeds that you can find also on the Jamendo homepage.
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about feeds from the Jamendo homepage.
#' See \url{https://developer.jamendo.com/v3.0/feeds} for more information.
#' @export

getFeed<-function(limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')){
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/feeds/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                limit = limit,
                lang = 'en')
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
  df<-json1[,c("id","title","link","position","date_start","date_end","type","joinid","text")]
  return(df)
}

