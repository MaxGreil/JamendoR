#' @title
#' Create OAuth token to access jamendo web API
#'
#' @description
#' \code{jamendoOAuth} creates a long-lived OAuth access token that enables R to make
#' authenticated calls to the Jamendo API. The token can be saved as a
#' file in disk to be re-used in future sessions. This function relies on the
#' \code{httr} package to create the OAuth token
#'@param app_name App name (this is an internal identification for token if you wish to save authorization)
#'@param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#'@param client_secret Defaults to System Environment variable "JAMENDO_CLIENT_SECRET"
#'@return Returns an OAuth access token as environment
#' @examples \donttest{
#' ## Example
#'  app_name = ""
#'  if(app_name != "") {
#'   my_oauth <- jamendoOAuth(app_name=app_name)
#'   filedir <- tempdir()
#'   save(my_oauth, file=file.path(filedir, "my_oauth"))
#'  }
#' }
#'
#'
#'@export

jamendoOAuth<-function(app_name, client_id = Sys.getenv('JAMENDO_CLIENT_ID'), client_secret = Sys.getenv('JAMENDO_CLIENT_SECRET')){
  endpoint <- httr::oauth_endpoint(authorize = 'https://api.jamendo.com/v3.0/oauth/authorize',
                                   access = 'https://api.jamendo.com/v3.0/oauth/grant')
  app <- httr::oauth_app(app_name, client_id, client_secret)
  return(httr::oauth2.0_token(endpoint = endpoint, app = app, scope = 'music',
                              user_params = list(grant_type = 'authorization_code')))

}

#' @title
#' Refresh expired OAuth token to access jamendo web API
#'
#' @description
#' \code{refreshToken} refreshes an OAuth access token that enables R to make
#' authenticated calls to the Jamendo API. The refreshed token can be saved as a
#' file in disk to be re-used in future sessions. This function relies on the
#' \code{httr} package to refresh the OAuth token
#'@param token OAuth access token (the previously created OAuth token)
#'@param client_id Defaults to System Environment variable "JAMENDO_CLIENT_ID"
#'@param client_secret Defaults to System Environment variable "JAMENDO_CLIENT_SECRET"
#'@return Returns an OAuth access token as environment
#' @examples \donttest{
#' ## Example
#'  app_name = ""
#'  if(app_name != "") {
#'   my_oauth <- jamendoOAuth(app_name=app_name)
#'   filedir <- tempdir()
#'   save(my_oauth, file=file.path(filedir, "my_oauth"))
#'   my_oauth <- resfreshToken(my_oauth)
#'   filedir <- tempdir()
#'   save(my_oauth, file=file.path(filedir, "my_oauth"))
#'  }
#' }
#'
#'@export

resfreshToken<-function(token, client_id = Sys.getenv('JAMENDO_CLIENT_ID'), client_secret = Sys.getenv('JAMENDO_CLIENT_SECRET')) {
  url <- 'https://api.jamendo.com/v3.0/oauth/grant'
  body <- list(grant_type = 'refresh_token', refresh_token = token$credentials$refresh_token)
  t <- httr::RETRY('POST', url, httr::accept_json(),
                   httr::authenticate(client_id, client_secret), body = body)
  post <- httr::content(t, "parsed")
  if(is.null(post$error)) {
    token$credentials$access_token = post$access_token
    token$credentials$refresh_token = post$refresh_token
    return(token)
  } else {
    stop(post$error_description)
  }
}
