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

#' Get List of Banks in Brazil
#'
#' This function retrieves the list of all banks in Brazil from the BrasilAPI endpoint:
#' `https://brasilapi.com.br/api/banks/v1`. The response includes key details such as
#' bank code, name, and ISPB (identificador do sistema de pagamentos).
#'
#' @return A tibble (data frame) with the following columns:
#' \itemize{
#'   \item \code{code}: Bank code (integer).
#'   \item \code{name}: Short name of the bank.
#'   \item \code{fullName}: Full registered name of the bank.
#'   \item \code{ispb}: ISPB code (Identificador do Sistema de Pagamentos Brasileiros).
#' }
#'
#' @examples
#' \dontrun{
#' banks <- get_brazil_banks()
#' head(banks)
#' }
#'
#' @note Requires internet connection. The function pulls data in real time from BrasilAPI.
#'
#' @seealso \code{\link[httr]{GET}}, \code{\link[jsonlite]{fromJSON}}, \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_banks <- function() {
  url <- "https://brasilapi.com.br/api/banks/v1"

  res <- httr::GET(url)

  if (res$status_code != 200) {
    message(paste("Error: Received status code", res$status_code))
    return(NULL)
  }

  res_content <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))

  df <- dplyr::as_tibble(res_content)

  return(df)
}
