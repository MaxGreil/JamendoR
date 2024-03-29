% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autocomplete.R
\name{getAutocompleteSearch}
\alias{getAutocompleteSearch}
\title{Search Jamendo database for a string}
\usage{
getAutocompleteSearch(
  prefix,
  limit = 10,
  client_id = Sys.getenv("JAMENDO_CLIENT_ID")
)
}
\arguments{
\item{prefix}{String to seach for}

\item{limit}{Integer to set the number of displayed search results. Maximum value is 200.}

\item{client_id}{Defaults to System Environment variable "JAMENDO_CLIENT_ID"}
}
\value{
Returns a data frame which contains found tracks, artists, albums and tags for a given string.
See \url{https://developer.jamendo.com/v3.0/autocomplete} for more information.
}
\description{
Search Jamendo database for a string
}
\examples{
\donttest{
##Example
 result <- getAutocompleteSearch("Chill", limit=3)
}
}
