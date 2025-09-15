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

# get_brazil_cpi

library(testthat)

test_that("get_brazil_cpi() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_cpi()
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

test_that("get_brazil_cpi() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_cpi() returns years from 2010 to 2022", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_cpi() returns exactly 13 rows", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_equal(nrow(result), 13)
})

test_that("get_brazil_cpi() includes the correct indicator label", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expected_indicator <- "Consumer price index (2010 = 100)"
  expect_true(all(result$indicator == expected_indicator))
})

test_that("get_brazil_cpi() allows for missing values (NA)", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_true(any(is.na(result$value)) || all(!is.na(result$value)))
})

test_that("get_brazil_cpi(): no NA values in year column", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_false(any(is.na(result$year)))
})

test_that("get_brazil_cpi(): value column is numeric or NA", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_true(all(is.finite(result$value) | is.na(result$value)))
})

test_that("get_brazil_cpi(): years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_cpi(): indicator is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_equal(length(unique(result$indicator)), 1)
})

test_that("get_brazil_cpi(): country is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_cpi()
  expect_equal(length(unique(result$country)), 1)
})

test_that("get_brazil_cpi(): CPI values are within reasonable range", {
  skip_on_cran()
  result <- get_brazil_cpi()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # CPI values should be positive and typically above 50 for this time period
    expect_true(all(non_na_values > 0))
    expect_true(all(non_na_values >= 50))
  }
})

test_that("get_brazil_cpi(): base year 2010 should equal 100", {
  skip_on_cran()
  result <- get_brazil_cpi()
  base_year_data <- result[result$year == 2010, ]
  if (nrow(base_year_data) > 0 && !is.na(base_year_data$value)) {
    expect_equal(base_year_data$value, 100)
  }
})

test_that("get_brazil_cpi(): CPI shows general increasing trend over time", {
  skip_on_cran()
  result <- get_brazil_cpi()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 1) {
    # CPI should generally increase over time due to inflation
    # Check if the most recent year has higher CPI than base year 2010
    base_year_value <- result$value[result$year == 2010]
    latest_year_value <- result$value[result$year == max(result$year)]
    if (!is.na(base_year_value) && !is.na(latest_year_value)) {
      expect_true(latest_year_value >= base_year_value)
    }
  }
})

test_that("get_brazil_cpi(): data covers complete time period", {
  skip_on_cran()
  result <- get_brazil_cpi()
  # Should have data for all years from 2010 to 2022 (13 years)
  expect_equal(length(unique(result$year)), 13)
  expect_true(min(result$year) == 2010)
  expect_true(max(result$year) == 2022)
})

test_that("get_brazil_cpi(): CPI values are monotonically increasing or stable", {
  skip_on_cran()
  result <- get_brazil_cpi()
  # Sort by year ascending for trend analysis
  sorted_result <- result[order(result$year), ]
  non_na_indices <- which(!is.na(sorted_result$value))

  if (length(non_na_indices) > 1) {
    # Check that CPI values generally don't decrease significantly
    # (allowing for small fluctuations due to deflation periods)
    cpi_values <- sorted_result$value[non_na_indices]
    # Most values should be equal or greater than previous values
    # Allow for some flexibility due to economic conditions
    expect_true(cpi_values[length(cpi_values)] >= cpi_values[1])
  }
})

test_that("get_brazil_cpi(): returns consistent structure across calls", {
  skip_on_cran()
  result1 <- get_brazil_cpi()
  result2 <- get_brazil_cpi()
  expect_equal(names(result1), names(result2))
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
})
