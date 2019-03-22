#' @title
#' Check if given variabels are null
#'
#' @description
#' \code{controlInputVariables} checks if given variabels id and name are null.
#' Returns an error if both variables id and name are null.
#' Returns warning if both variables id and name are not null.
#' @param id String to check
#' @param name String to check
#' @export

controlInputVariables<-function(id,name) {
  if(is.null(id) && is.null(name)) {
    stop(paste0('Search either for ', deparse(substitute(id)),' or ', deparse(substitute(name))))
  }
  if(!is.null(id) && !is.null(name)) {
    warning(paste0('Search for ', deparse(substitute(id)), ' only'))
  }
}

#' @title
#' Check if given limit is smaller than 200
#'
#' @description
#' \code{controlLimit} checks if  given limit is smaller than 200.
#' Returns warning if limit is greater than 200 and sets limit to 200.
#' @param limit Integer to check
#' @export

controlLimit<-function(limit) {
  if(limit > 200) {
    warning("Limit must not be greater than 200")
    limit = 200
  }
  return(limit)
}

#' @title
#' Parse response from POST request for setUser functions
#'
#' @description
#' \code{parse} parses response from POST request for setUser functions.
#' @param res String from POST request
#' @export

parseResponse<-function(res) {
  pos1 <- gregexpr(pattern ='code', res)
  pos2 <- gregexpr(pattern ='error_message', res)
  code <- gsub("[\":, ]", "", substr(res, pos1[[1]][1]+4, pos2[[1]][1]-1))
  if(code != '0') {
    pos1 <- gregexpr(pattern ='error_message', res)
    pos2 <- gregexpr(pattern ='warnings', res)
    stop(gsub("[\":.,]", "", substr(res, pos1[[1]][1]+13, pos2[[1]][1]-1)))
  } else {
    message("Success")
  }
}
