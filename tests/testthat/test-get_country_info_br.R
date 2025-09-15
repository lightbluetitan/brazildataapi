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

# get_country_info_br


library(testthat)

test_that("get_country_info_br() returns tibble with correct structure", {
  result <- get_country_info_br()
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("name_common", "name_official", "region", "subregion",
                         "capital", "area", "population", "languages"))
  expect_equal(nrow(result), 1)
  expect_equal(ncol(result), 8)
})

test_that("get_country_info_br() returns data of correct types", {
  result <- get_country_info_br()
  expect_type(result$name_common, "character")
  expect_type(result$name_official, "character")
  expect_type(result$region, "character")
  expect_type(result$subregion, "character")
  expect_type(result$capital, "character")
  expect_type(result$area, "double")
  expect_type(result$population, "integer")
  expect_type(result$languages, "character")
})

test_that("get_country_info_br() returns expected values for Brazil", {
  result <- get_country_info_br()
  expect_equal(result$name_common, "Brazil")
  expect_equal(result$name_official, "Federative Republic of Brazil")
  expect_equal(result$region, "Americas")
  expect_equal(result$subregion, "South America")
  expect_equal(result$capital, "Brasília")
  expect_true(result$area > 8000000)
  expect_true(result$population > 200000000)
  expect_true(grepl("Portuguese", result$languages))
})

test_that("get_country_info_br() returns non-empty character values", {
  result <- get_country_info_br()
  expect_true(nchar(result$name_common) > 0)
  expect_true(nchar(result$name_official) > 0)
  expect_true(nchar(result$region) > 0)
  expect_true(nchar(result$subregion) > 0)
  expect_true(nchar(result$capital) > 0)
  expect_true(nchar(result$languages) > 0)
})

test_that("get_country_info_br() returns positive numeric values", {
  result <- get_country_info_br()
  expect_true(result$area > 0)
  expect_true(result$population > 0)
  expect_true(is.finite(result$area))
  expect_true(is.finite(result$population))
})

test_that("get_country_info_br() area is approximately correct for Brazil", {
  result <- get_country_info_br()
  # Brazil's area should be approximately 8.5 million km²
  expect_true(result$area >= 8000000)
  expect_true(result$area <= 9000000)
})

test_that("get_country_info_br() population is within reasonable range", {
  result <- get_country_info_br()
  # Brazil's population should be over 200 million but under 300 million
  expect_true(result$population >= 200000000)
  expect_true(result$population <= 300000000)
})

test_that("get_country_info_br() returns consistent data types across calls", {
  result1 <- get_country_info_br()
  result2 <- get_country_info_br()
  expect_equal(sapply(result1, class), sapply(result2, class))
})

test_that("get_country_info_br() returns identical results on multiple calls", {
  result1 <- get_country_info_br()
  result2 <- get_country_info_br()
  expect_identical(result1, result2)
})

test_that("get_country_info_br() has no missing values in required fields", {
  result <- get_country_info_br()
  expect_false(is.na(result$name_common))
  expect_false(is.na(result$name_official))
  expect_false(is.na(result$region))
  expect_false(is.na(result$subregion))
  expect_false(is.na(result$capital))
  expect_false(is.na(result$area))
  expect_false(is.na(result$population))
  expect_false(is.na(result$languages))
})


