# BrazilDataAPI - Access Brazilian Economic, Demographic, Environmental, and Geopolitical Data via RESTful APIs and Curated Datasets
# Version 0.1.0
# Copyright (C) 2025 Renzo Caceres Rossi
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#' Get Address Information by Brazilian CEP (Postal Code)
#'
#' This function retrieves detailed address information for a given Brazilian
#' postal code (CEP) using the BrasilAPI endpoint.
#'
#' Example URL format: \url{https://brasilapi.com.br/api/cep/v1/89010025}
#'
#' Replace \code{89010025} with any valid Brazilian postal code (CEP).
#'
#' @param cep A valid Brazilian postal code (CEP) with 8 digits (e.g., "89010025").
#'
#' @return A data frame (tibble) with the following columns:
#' \itemize{
#'   \item \code{cep}: The CEP (postal code).
#'   \item \code{state}: State abbreviation (e.g., SP, RJ).
#'   \item \code{city}: City or municipality.
#'   \item \code{neighborhood}: Neighborhood.
#'   \item \code{street}: Street name.
#'   \item \code{service}: Name of the API service used.
#' }
#'
#' @details
#' The function sends a GET request to the BrasilAPI CEP endpoint. If the request
#' is successful and the response contains the expected fields, it returns a
#' structured tibble. Otherwise, a message is displayed and \code{NULL} is returned.
#'
#' @examples
#' \dontrun{
#' # Look up information for a specific CEP
#' get_brazil_cep("89010025")
#' }
#'
#' @note
#' Requires an internet connection. Make sure the CEP is correctly formatted (only digits, 8 characters).
#'
#' @seealso
#' \code{\link[httr]{GET}}, \code{\link[jsonlite]{fromJSON}}, \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_cep <- function(cep) {
  url <- paste0("https://brasilapi.com.br/api/cep/v1/", cep)

  res <- httr::GET(url)

  if (res$status_code != 200) {
    message(paste("Error: Received status code", res$status_code))
    return(NULL)
  }

  res_content <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"), flatten = TRUE)

  if (!all(c("cep", "state", "city", "neighborhood", "street", "service") %in% names(res_content))) {
    message("Error: Missing expected fields in API response.")
    return(NULL)
  }

  df <- dplyr::as_tibble(res_content)

  return(df)
}
