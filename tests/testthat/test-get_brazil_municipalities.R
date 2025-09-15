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

# get_brazil_municipalities

library(testthat)

test_that("get_brazil_municipalities() returns a valid tibble for a valid UF", {
  skip_on_cran()

  result <- get_brazil_municipalities("SP")

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)

  expected_cols <- c("nome", "codigo_ibge")
  expect_true(all(expected_cols %in% names(result)))
  expect_equal(ncol(result), length(expected_cols))

  # Column type checks
  expect_type(result$nome, "character")
  expect_type(result$codigo_ibge, "character")

  # IBGE code should be 7-digit numeric strings
  expect_true(all(is.na(result$codigo_ibge) | grepl("^[0-9]{7}$", result$codigo_ibge)))
})

test_that("get_brazil_municipalities() returns NULL for invalid UF", {
  skip_on_cran()
  result <- get_brazil_municipalities("XX")
  expect_null(result)
})

test_that("get_brazil_municipalities() returns NULL for malformed input", {
  skip_on_cran()
  expect_null(get_brazil_municipalities(""))
  expect_null(get_brazil_municipalities("123"))
})

test_that("get_brazil_municipalities() requires input argument", {
  expect_error(get_brazil_municipalities(), "argument \"uf\" is missing")
})

