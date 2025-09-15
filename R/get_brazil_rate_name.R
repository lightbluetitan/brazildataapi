# BrazilDataAPI - Access Brazilian Data via APIs and Curated Datasets
# Version 0.2.0
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

#' Get Specific Brazilian Economic Rate by Name
#'
#' This function retrieves the value of a specific Brazilian economic rate (e.g., "CDI", "Selic", "IPCA")
#' from the BrasilAPI endpoint.
#'
#' @param rate_name A character string indicating the rate to retrieve. Valid examples include
#'   \code{"CDI"}, \code{"Selic"}, or \code{"IPCA"}. Case-insensitive.
#'
#' @return A tibble with two columns: \code{nome} (name of rate) and \code{valor} (numeric value).
#'
#' @examples
#' \dontrun{
#' get_brazil_rate_name("CDI")
#' get_brazil_rate_name("Selic")
#' get_brazil_rate_name("IPCA")
#' }
#'
#' @seealso \code{\link{get_brazil_rates}} to retrieve all rates at once.
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_rate_name <- function(rate_name) {
  url <- paste0("https://brasilapi.com.br/api/taxas/v1/", tolower(rate_name))

  res <- httr::GET(url)

  if (res$status_code != 200) {
    message(paste("Error: Received status code", res$status_code))
    return(NULL)
  }

  content <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))
  dplyr::as_tibble(content)
}
