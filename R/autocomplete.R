#' Search Jamendo database for a string
#' @param prefix String to seach for
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains found tracks, artists, albums and tags for a given string.
#' See \url{https://developer.jamendo.com/v3.0/autocomplete} for more information.
#' @examples \donttest{
#' ##Example
#'  result <- getAutocompleteSearch("Chill", limit=3)
#' }
#' @export

getAutocompleteSearch<-function(prefix, limit=10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')){
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/autocomplete/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                limit = limit,
                prefix = prefix)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
  df=json1[c("tracks", "artists", "albums", "tags")]
  return(df)
}
