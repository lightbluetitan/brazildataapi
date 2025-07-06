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

# get_brazil_rates

library(testthat)

test_that("get_brazil_rates() returns a valid tibble with correct structure", {
  skip_on_cran()
  result <- get_brazil_rates()

  # Basic checks
  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)

  # Check for expected columns
  expect_named(result, c("nome", "valor"))

  # Column types
  expect_type(result$nome, "character")
  expect_true(typeof(result$valor) %in% c("double", "integer"))

  # Check presence of known rates (case-insensitive match)
  known_rates <- c("CDI", "SELIC", "IPCA")
  expect_true(all(known_rates %in% toupper(result$nome)))
})

test_that("get_brazil_rates() returns valid values", {
  skip_on_cran()
  result <- get_brazil_rates()

  # Value column should be numeric (either integer or double)
  expect_true(is.numeric(result$valor))

  # Values should be non-negative
  expect_true(all(result$valor >= 0))
})

test_that("get_brazil_rates() does not return NULL on valid request", {
  skip_on_cran()
  result <- get_brazil_rates()
  expect_false(is.null(result))
})

test_that("get_brazil_rates() returns a tibble with two columns only", {
  skip_on_cran()
  result <- get_brazil_rates()
  expect_equal(ncol(result), 2)
  expect_named(result, c("nome", "valor"))
})
