#' @title This method returns information about a jamendo radio
#' @description This method returns information about a jamendo radio. You can search for either a radio ID or a radio name.
#' @param radio_id Radio ID to seach for
#' @param radio_name Radio name to seach for
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a radio.
#' See \url{https://developer.jamendo.com/v3.0/radios} for more information.
#' @examples \dontrun{
#' ##Example
#'  radioID <- getRadio(radio_id="1")
#'  radioName <- getRadio(radio_name="bestof")
#' }
#' @export

getRadio<-function(radio_id=NULL, radio_name=NULL, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  controlInputVariables(radio_id,radio_name)
  url <- 'https://api.jamendo.com/v3.0/radios/'
  if(is.null(radio_id)) {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  name = radio_name)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  } else {
    params = list(client_id = client_id,
                  format = 'jsonpretty',
                  id = radio_id)
    res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  }
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","dispname","type")]
    return(df)
  }
}

#' This method returns the list of existing jamendo radios
#' @param limit Integer to set the number of displayed search results. Maximum value is 200.
#' @param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#' @return Returns a data frame which contains information about a radio.
#' See \url{https://developer.jamendo.com/v3.0/radios} for more information.
#' @export

getRadios<-function(limit = 10, client_id = Sys.getenv('JAMENDO_CLIENT_ID')) {
  limit <- controlLimit(limit)
  url <- 'https://api.jamendo.com/v3.0/radios/'
  params = list(client_id = client_id,
                format = 'jsonpretty',
                limit = limit)
  res <- httr::RETRY('GET', url, query = params, encode='json') %>% httr::content()
  if(length(res$results) > 0) {
    json1<-jsonlite::fromJSON(jsonlite::toJSON(res))$results
    df=json1[,c("id","name","dispname","type")]
    return(df)
  }
}
