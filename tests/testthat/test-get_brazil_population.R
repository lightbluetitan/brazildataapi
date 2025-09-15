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

# get_brazil_population

library(testthat)

test_that("get_brazil_population() returns tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_population()
  # Structure
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("indicator", "country", "year", "value", "value_label"))
  expect_equal(ncol(result), 5)
  expect_equal(nrow(result), 13)  # 2010–2022 inclusive

  # Types
  expect_type(result$indicator, "character")
  expect_type(result$country, "character")
  expect_type(result$year, "integer")
  expect_true(is.numeric(result$value))  # population should be numeric
  expect_type(result$value_label, "character")
})

test_that("get_brazil_population() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_population() returns correct indicator label", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_true(all(result$indicator == "Population, total"))
})

test_that("get_brazil_population() covers the correct years (2010–2022)", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_population() years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_population() value column has no missing values", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_false(any(is.na(result$value)))
  expect_true(all(result$value > 0))
})

test_that("get_brazil_population() value_label matches value formatting", {
  skip_on_cran()
  result <- get_brazil_population()
  formatted_values <- scales::comma(result$value, accuracy = 1)
  expect_equal(result$value_label, formatted_values)
})

test_that("get_brazil_population() indicator and country columns are consistent", {
  skip_on_cran()
  result <- get_brazil_population()
  expect_equal(length(unique(result$indicator)), 1)
  expect_equal(length(unique(result$country)), 1)
})
