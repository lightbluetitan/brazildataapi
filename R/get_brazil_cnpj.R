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

#' Get Company Information by CNPJ (Brazil)
#'
#' This function retrieves public company registration data in Brazil by querying the BrasilAPI endpoint.
#'
#' Example URL format: \url{https://brasilapi.com.br/api/cnpj/v1/19131243000197}
#'
#' Replace \code{19131243000197} with any valid Brazilian CNPJ number.
#'
#' It returns a tibble with essential information such as the company's legal name, trade name,
#' address, primary activity, and registration status.
#'
#' @param cnpj A valid CNPJ number as a string (only digits, no punctuation).
#'
#' @return A tibble with selected essential fields:
#' \itemize{
#'   \item \code{cnpj}: CNPJ identifier.
#'   \item \code{razao_social}: Legal name.
#'   \item \code{nome_fantasia}: Trade name.
#'   \item \code{capital_social}: Registered capital (numeric).
#'   \item \code{data_inicio_atividade}: Start date of activities.
#'   \item \code{cnae_fiscal_descricao}: Main economic activity.
#'   \item \code{natureza_juridica}: Legal nature.
#'   \item \code{descricao_situacao_cadastral}: Registration status.
#'   \item \code{municipio}: City.
#'   \item \code{uf}: State.
#'   \item \code{cep}: Postal code.
#'   \item \code{logradouro}: Address (street).
#'   \item \code{numero}: Address number.
#'   \item \code{bairro}: Neighborhood.
#' }
#'
#' @details
#' The function makes an HTTP GET request to the BrasilAPI CNPJ endpoint and processes the JSON response
#' into a structured tibble. It only returns fields that are essential and informative for the user.
#'
#' @examples
#' \dontrun{
#' get_brazil_cnpj("19131243000197")
#' }
#'
#' @note Requires internet connection. The function returns \code{NULL} if the CNPJ is invalid or not found.
#'
#' @seealso \code{\link[httr]{GET}}, \code{\link[jsonlite]{fromJSON}}, \code{\link[dplyr]{as_tibble}}
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#'
#' @export
get_brazil_cnpj <- function(cnpj) {
  url <- paste0("https://brasilapi.com.br/api/cnpj/v1/", cnpj)
  res <- httr::GET(url)

  if (res$status_code != 200) {
    message(paste("Error: status", res$status_code, "- CNPJ not found or invalid."))
    return(NULL)
  }

  raw <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"), flatten = TRUE)

  selected <- list(
    cnpj = raw$cnpj,
    razao_social = raw$razao_social,
    nome_fantasia = raw$nome_fantasia,
    capital_social = raw$capital_social,
    data_inicio_atividade = raw$data_inicio_atividade,
    cnae_fiscal_descricao = raw$cnae_fiscal_descricao,
    natureza_juridica = raw$natureza_juridica,
    descricao_situacao_cadastral = raw$descricao_situacao_cadastral,
    municipio = raw$municipio,
    uf = raw$uf,
    cep = raw$cep,
    logradouro = raw$logradouro,
    numero = raw$numero,
    bairro = raw$bairro
  )

  dplyr::as_tibble(selected)
}
