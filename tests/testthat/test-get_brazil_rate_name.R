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

# get_brazil_rate_name

library(testthat)

# Test 1: CDI
test_that("get_brazil_rate_name('CDI') returns correct structure and types", {
  skip_on_cran()
  result <- get_brazil_rate_name("CDI")

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("nome", "valor"))
  expect_type(result$nome, "character")
  expect_true(typeof(result$valor) %in% c("double", "integer"))
  expect_true(toupper(result$nome[1]) == "CDI")
})

# Test 2: SELIC
test_that("get_brazil_rate_name('Selic') returns correct structure and types", {
  skip_on_cran()
  result <- get_brazil_rate_name("Selic")

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("nome", "valor"))
  expect_type(result$nome, "character")
  expect_true(typeof(result$valor) %in% c("double", "integer"))
  expect_true(toupper(result$nome[1]) == "SELIC")
})

# Test 3: IPCA
test_that("get_brazil_rate_name('IPCA') returns correct structure and types", {
  skip_on_cran()
  result <- get_brazil_rate_name("IPCA")

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("nome", "valor"))
  expect_type(result$nome, "character")
  expect_true(typeof(result$valor) %in% c("double", "integer"))
  expect_true(toupper(result$nome[1]) == "IPCA")
})

# Test 4: Case-insensitive input
test_that("get_brazil_rate_name() is case-insensitive", {
  skip_on_cran()
  upper <- get_brazil_rate_name("IPCA")
  lower <- get_brazil_rate_name("ipca")
  expect_equal(upper, lower)
})

# Test 5: Invalid input returns NULL
test_that("get_brazil_rate_name() returns NULL for invalid rate", {
  skip_on_cran()
  result <- get_brazil_rate_name("invalidrate")
  expect_null(result)
})

# Test 6: Missing argument
test_that("get_brazil_rate_name() fails if no argument is provided", {
  expect_error(get_brazil_rate_name(), "argument.*is missing")
})

# Test 7: Non-character input returns NULL (since function allows it)
test_that("get_brazil_rate_name() handles non-character input gracefully", {
  skip_on_cran()
  result <- get_brazil_rate_name(123)
  expect_true(is.null(result) || inherits(result, "tbl_df"))
})
