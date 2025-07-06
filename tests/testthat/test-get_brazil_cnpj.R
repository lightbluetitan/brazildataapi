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

# get_brazil_cnpj

library(testthat)

test_that("get_brazil_cnpj() returns a valid tibble with expected structure for known CNPJ", {
  skip_on_cran()

  result <- get_brazil_cnpj("19131243000197")

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1)

  expected_cols <- c(
    "cnpj", "razao_social", "nome_fantasia", "capital_social", "data_inicio_atividade",
    "cnae_fiscal_descricao", "natureza_juridica", "descricao_situacao_cadastral",
    "municipio", "uf", "cep", "logradouro", "numero", "bairro"
  )
  expect_true(all(expected_cols %in% names(result)))
  expect_equal(ncol(result), length(expected_cols))

  # Type checks
  expect_type(result$cnpj, "character")
  expect_type(result$razao_social, "character")
  expect_type(result$nome_fantasia, "character")
  expect_type(result$capital_social, "integer")
  expect_type(result$data_inicio_atividade, "character")
  expect_type(result$cnae_fiscal_descricao, "character")
  expect_type(result$natureza_juridica, "character")
  expect_type(result$descricao_situacao_cadastral, "character")
  expect_type(result$municipio, "character")
  expect_type(result$uf, "character")
  expect_type(result$cep, "character")
  expect_type(result$logradouro, "character")
  expect_type(result$numero, "character")
  expect_type(result$bairro, "character")
})

test_that("get_brazil_cnpj() handles invalid CNPJ input gracefully", {
  skip_on_cran()

  result <- get_brazil_cnpj("00000000000000")  # invalid or non-existent CNPJ
  expect_null(result)
})

test_that("get_brazil_cnpj() returns NULL for malformed input", {
  expect_null(get_brazil_cnpj("INVALID"))
  expect_null(get_brazil_cnpj(""))
})

test_that("get_brazil_cnpj() requires input argument", {
  expect_error(get_brazil_cnpj(), "argument \"cnpj\" is missing")
})
