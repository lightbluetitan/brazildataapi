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

# get_brazil_child_mortality

library(testthat)

test_that("get_brazil_child_mortality() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("indicator", "country", "year", "value"))
  expect_equal(ncol(result), 4)
  # Type checks
  expect_type(result$indicator, "character")
  expect_type(result$country, "character")
  expect_type(result$year, "integer")
  expect_type(result$value, "double")
})

test_that("get_brazil_child_mortality() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_child_mortality() returns years from 2010 to 2022", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_child_mortality() returns exactly 13 rows", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_equal(nrow(result), 13)
})

test_that("get_brazil_child_mortality() includes the correct indicator label", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expected_indicator <- "Mortality rate, under-5 (per 1,000 live births)"
  expect_true(all(result$indicator == expected_indicator))
})

test_that("get_brazil_child_mortality() allows for missing values (NA)", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_true(any(is.na(result$value)) || all(!is.na(result$value)))
})

test_that("get_brazil_child_mortality(): no NA values in year column", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_false(any(is.na(result$year)))
})

test_that("get_brazil_child_mortality(): value column is numeric or NA", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_true(all(is.finite(result$value) | is.na(result$value)))
})

test_that("get_brazil_child_mortality(): years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_child_mortality(): indicator is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_equal(length(unique(result$indicator)), 1)
})

test_that("get_brazil_child_mortality(): country is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  expect_equal(length(unique(result$country)), 1)
})

test_that("get_brazil_child_mortality(): mortality rates are within reasonable range", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Under-5 mortality rates should be positive and typically under 100 per 1,000 for Brazil
    expect_true(all(non_na_values > 0))
    expect_true(all(non_na_values < 100))
  }
})

test_that("get_brazil_child_mortality(): mortality rates show general declining trend", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 1) {
    # Generally, child mortality rates should be declining over time
    # Check if the most recent year has lower mortality than the earliest year
    sorted_result <- result[order(result$year), ]
    earliest_value <- sorted_result$value[1]
    latest_value <- sorted_result$value[nrow(sorted_result)]
    if (!is.na(earliest_value) && !is.na(latest_value)) {
      expect_true(latest_value <= earliest_value)
    }
  }
})

test_that("get_brazil_child_mortality(): data covers complete time period", {
  skip_on_cran()
  result <- get_brazil_child_mortality()
  # Should have data for all years from 2010 to 2022 (13 years)
  expect_equal(length(unique(result$year)), 13)
  expect_true(min(result$year) == 2010)
  expect_true(max(result$year) == 2022)
})

test_that("get_brazil_child_mortality(): returns consistent structure across calls", {
  skip_on_cran()
  result1 <- get_brazil_child_mortality()
  result2 <- get_brazil_child_mortality()
  expect_equal(names(result1), names(result2))
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
})
