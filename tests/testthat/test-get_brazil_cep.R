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

# get_brazil_cep

library(testthat)

test_that("get_brazil_cep() returns a valid tibble with correct structure for a known CEP", {
  skip_on_cran()

  result <- get_brazil_cep("89010025")

  # Must not be NULL
  expect_false(is.null(result))

  # Must be a tibble
  expect_s3_class(result, "tbl_df")

  # Must have exactly one row
  expect_equal(nrow(result), 1)

  # Must contain the expected columns
  expected_columns <- c("cep", "state", "city", "neighborhood", "street", "service")
  expect_true(all(expected_columns %in% names(result)))
  expect_equal(ncol(result), length(expected_columns))

  # Column type checks
  expect_type(result$cep, "character")
  expect_type(result$state, "character")
  expect_type(result$city, "character")
  expect_type(result$neighborhood, "character")
  expect_type(result$street, "character")
  expect_type(result$service, "character")
})

test_that("get_brazil_cep() handles invalid CEP gracefully", {
  skip_on_cran()

  result <- get_brazil_cep("00000000")  # Invalid CEP example
  expect_null(result)
})

test_that("get_brazil_cep() returns NULL for non-numeric or malformed input", {
  expect_null(get_brazil_cep("INVALID"))
  expect_null(get_brazil_cep(""))
})

test_that("get_brazil_cep() requires input argument", {
  expect_error(get_brazil_cep(), "argument \"cep\" is missing")
})
