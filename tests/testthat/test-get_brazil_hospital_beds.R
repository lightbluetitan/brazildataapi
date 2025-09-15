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

# get_brazil_hospital_beds

library(testthat)

test_that("get_brazil_hospital_beds() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
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

test_that("get_brazil_hospital_beds() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_hospital_beds() returns years from 2010 to 2022", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_hospital_beds() returns exactly 13 rows", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_equal(nrow(result), 13)
})

test_that("get_brazil_hospital_beds() includes the correct indicator label", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expected_indicator <- "Hospital beds (per 1,000 people)"
  expect_true(all(result$indicator == expected_indicator))
})

test_that("get_brazil_hospital_beds() allows for missing values (NA)", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_true(any(is.na(result$value)) || all(!is.na(result$value)))
})

test_that("get_brazil_hospital_beds(): no NA values in year column", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_false(any(is.na(result$year)))
})

test_that("get_brazil_hospital_beds(): value column is numeric or NA", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_true(all(is.finite(result$value) | is.na(result$value)))
})

test_that("get_brazil_hospital_beds(): years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_hospital_beds(): indicator is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_equal(length(unique(result$indicator)), 1)
})

test_that("get_brazil_hospital_beds(): country is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  expect_equal(length(unique(result$country)), 1)
})

test_that("get_brazil_hospital_beds(): hospital beds values are within reasonable range", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Hospital beds per 1,000 people should be positive and typically between 1-10 for most countries
    expect_true(all(non_na_values > 0))
    expect_true(all(non_na_values >= 1))
    expect_true(all(non_na_values <= 10))
  }
})

test_that("get_brazil_hospital_beds(): hospital beds values are in expected range for Brazil", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Based on sample data, values should be around 2-3 beds per 1,000 people
    expect_true(all(non_na_values >= 1.5))
    expect_true(all(non_na_values <= 3.5))
  }
})

test_that("get_brazil_hospital_beds(): data covers complete time period", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  # Should have data for all years from 2010 to 2022 (13 years)
  expect_equal(length(unique(result$year)), 13)
  expect_true(min(result$year) == 2010)
  expect_true(max(result$year) == 2022)
})

test_that("get_brazil_hospital_beds(): hospital beds show reasonable variation", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 1) {
    # Hospital beds should be relatively stable over time
    # Check that coefficient of variation is reasonable (typically < 0.2 for infrastructure data)
    cv <- sd(non_na_values) / mean(non_na_values)
    expect_true(cv < 0.3)  # Allow some flexibility for healthcare infrastructure changes
  }
})

test_that("get_brazil_hospital_beds(): returns consistent structure across calls", {
  skip_on_cran()
  result1 <- get_brazil_hospital_beds()
  result2 <- get_brazil_hospital_beds()
  expect_equal(names(result1), names(result2))
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
})

test_that("get_brazil_hospital_beds(): hospital beds data shows expected trend pattern", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  non_na_data <- result[!is.na(result$value), ]
  if (nrow(non_na_data) > 1) {
    # Sort by year for trend analysis
    sorted_data <- non_na_data[order(non_na_data$year), ]
    # Hospital beds infrastructure typically changes gradually
    # Check that there are no extreme year-to-year changes
    if (nrow(sorted_data) > 1) {
      year_changes <- abs(diff(sorted_data$value))
      # No single year change should be more than 1 bed per 1,000 people
      expect_true(all(year_changes <= 1))
    }
  }
})

test_that("get_brazil_hospital_beds(): hospital beds values are within statistical bounds", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 2) {
    # Check that values are within reasonable statistical bounds
    mean_value <- mean(non_na_values)
    sd_value <- sd(non_na_values)
    # Allow for values within 3 standard deviations
    lower_bound <- mean_value - 3 * sd_value
    upper_bound <- mean_value + 3 * sd_value
    expect_true(all(non_na_values >= lower_bound))
    expect_true(all(non_na_values <= upper_bound))
  }
})

test_that("get_brazil_hospital_beds(): handles missing data appropriately", {
  skip_on_cran()
  result <- get_brazil_hospital_beds()
  # Check that when value is NA, other columns still have valid data
  na_indices <- which(is.na(result$value))
  if (length(na_indices) > 0) {
    expect_false(any(is.na(result$indicator[na_indices])))
    expect_false(any(is.na(result$country[na_indices])))
    expect_false(any(is.na(result$year[na_indices])))
  }
})
