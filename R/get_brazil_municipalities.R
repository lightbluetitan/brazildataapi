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

#' Get Municipalities of a Brazilian State from IBGE
#'
#' This function retrieves a list of municipalities from the Brazilian IBGE API using
#' the state abbreviation (UF). It includes the name of each municipality and its official
#' IBGE code.
#'
#' @param uf A two-letter string representing the Brazilian state abbreviation (e.g., "SP", "RJ", "BA").
#'
#' @return A data frame (tibble) with the following columns:
#' \itemize{
#'   \item \code{nome}: Name of the municipality.
#'   \item \code{codigo_ibge}: Official IBGE code for the municipality (as character).
#' }
#'
#' @details
#' The function sends a GET request to the BrasilAPI IBGE endpoint. If the UF (state abbreviation)
#' is invalid or not recognized, the function returns \code{NULL} with an appropriate message.
#'
#' @examples
#' \dontrun{
#' municipalities_sp <- get_brazil_municipalities("SP")
#' head(municipalities_sp)
#' }
#'
#' @note
#' Requires internet access. Official IBGE codes are widely used for geostatistical analysis
#' and identification of Brazilian municipalities.
#'
#' @seealso
#' \code{\link[httr]{GET}}, \code{\link[jsonlite]{fromJSON}}, \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_municipalities <- function(uf) {
  url <- paste0("https://brasilapi.com.br/api/ibge/municipios/v1/", uf, "?providers=dados-abertos-br,gov,wikipedia")

  res <- httr::GET(url)

  if (res$status_code != 200) {
    message("Error: Invalid or unrecognized UF (state abbreviation).")
    return(NULL)
  }

  res_content <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))

  df <- dplyr::as_tibble(res_content)

  return(df)
}
