#' \code{jamendoR} package
#'
#' A Quick and Easy Wrapper for Pulling Track Audio Features from Jamendo's Web API
#'
#'
#' @docType package
#' @name jamendoR
#' @import dplyr
#' @importFrom dplyr %>%
#' @importFrom stats setNames
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1") utils::globalVariables(c("."))
