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

#' Get Vehicle Brands from BrasilAPI (FIPE Data)
#'
#' This function retrieves a list of vehicle brands in Brazil using the BrasilAPI
#' endpoint, which provides data sourced from FIPE (Fundação Instituto de Pesquisas Econômicas).
#' The user must specify the type of vehicle: `"carros"`, `"motos"`, or `"caminhoes"`.
#'
#' @param tipo_veiculo A string indicating the type of vehicle. Must be one of `"carros"`, `"motos"`, or `"caminhoes"`.
#'
#' @return A tibble (data frame) with the following columns:
#' \itemize{
#'   \item \code{nome}: Brand name.
#'   \item \code{valor}: FIPE code of the brand.
#' }
#'
#' @details
#' This function sends a GET request to the BrasilAPI endpoint and parses the list of vehicle brands.
#' If the API returns an error (e.g., invalid vehicle type), the function will return \code{NULL}.
#'
#' @examples
#' \dontrun{
#' # Retrieve list of car brands
#' cars <- get_brazil_vehicle_brands("carros")
#' head(cars)
#' }
#'
#' @note
#' Requires internet connection. Only supports Brazilian vehicle types defined by BrasilAPI.
#'
#' @seealso
#' \code{\link[httr]{GET}}, \code{\link[jsonlite]{fromJSON}}, \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_vehicle_brands <- function(tipo_veiculo) {
  base_url <- "https://brasilapi.com.br/api/fipe/marcas/v1/"
  url <- paste0(base_url, tipo_veiculo)

  res <- httr::GET(url)

  if (res$status_code != 200) {
    message(paste("Error: Received status code", res$status_code))
    return(NULL)
  }

  res_content <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))

  df <- dplyr::as_tibble(res_content)

  return(df)
}
