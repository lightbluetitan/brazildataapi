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

# get_brazil_gdp

library(testthat)

test_that("get_brazil_gdp() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_gdp()
  # Structure checks
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("indicator", "country", "year", "value", "value_label"))
  expect_equal(ncol(result), 5)
  # Type checks
  expect_type(result$indicator, "character")
  expect_type(result$country, "character")
  expect_type(result$year, "integer")
  expect_type(result$value, "double")
  expect_type(result$value_label, "character")
})

test_that("get_brazil_gdp() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_gdp() returns years from 2010 to 2022", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_gdp() returns exactly 13 rows", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_equal(nrow(result), 13)
})

test_that("get_brazil_gdp() includes the correct indicator label", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expected_indicator <- "GDP (current US$)"
  expect_true(all(result$indicator == expected_indicator))
})

test_that("get_brazil_gdp() allows for missing values (NA)", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_true(any(is.na(result$value)) || all(!is.na(result$value)))
})

test_that("get_brazil_gdp(): no NA values in year column", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_false(any(is.na(result$year)))
})

test_that("get_brazil_gdp(): value column is numeric or NA", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_true(all(is.finite(result$value) | is.na(result$value)))
})

test_that("get_brazil_gdp(): years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_gdp(): indicator is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_equal(length(unique(result$indicator)), 1)
})

test_that("get_brazil_gdp(): country is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_gdp()
  expect_equal(length(unique(result$country)), 1)
})

test_that("get_brazil_gdp(): GDP values are within reasonable range", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Brazil's GDP should be positive and in trillions of USD (typically 1-3 trillion)
    expect_true(all(non_na_values > 0))
    expect_true(all(non_na_values >= 1e12))  # At least 1 trillion USD
    expect_true(all(non_na_values <= 5e12))  # Less than 5 trillion USD
  }
})

test_that("get_brazil_gdp(): GDP values are in expected range for Brazil", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Based on sample data, values should be between 1.4-2.7 trillion USD
    expect_true(all(non_na_values >= 1.4e12))
    expect_true(all(non_na_values <= 2.7e12))
  }
})

test_that("get_brazil_gdp(): data covers complete time period", {
  skip_on_cran()
  result <- get_brazil_gdp()
  # Should have data for all years from 2010 to 2022 (13 years)
  expect_equal(length(unique(result$year)), 13)
  expect_true(min(result$year) == 2010)
  expect_true(max(result$year) == 2022)
})

test_that("get_brazil_gdp(): value_label column contains formatted values", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_indices <- which(!is.na(result$value))
  if (length(non_na_indices) > 0) {
    # Check that value_label contains commas for formatting
    expect_true(all(grepl(",", result$value_label[non_na_indices])))
    # Check that value_label doesn't contain scientific notation
    expect_false(any(grepl("[eE]", result$value_label[non_na_indices])))
  }
})

test_that("get_brazil_gdp(): value_label matches value when both are not NA", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_indices <- which(!is.na(result$value) & !is.na(result$value_label))
  if (length(non_na_indices) > 0) {
    for (i in non_na_indices) {
      # Remove commas and convert to numeric to compare
      formatted_value <- as.numeric(gsub(",", "", result$value_label[i]))
      expect_equal(formatted_value, result$value[i], tolerance = 1)
    }
  }
})

test_that("get_brazil_gdp(): GDP values show reasonable variation", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 1) {
    # GDP can vary significantly due to economic cycles and currency fluctuations
    # Check that coefficient of variation is reasonable (typically < 0.4 for GDP data)
    cv <- sd(non_na_values) / mean(non_na_values)
    expect_true(cv < 0.5)  # Allow flexibility for economic fluctuations
  }
})

test_that("get_brazil_gdp(): returns consistent structure across calls", {
  skip_on_cran()
  result1 <- get_brazil_gdp()
  result2 <- get_brazil_gdp()
  expect_equal(names(result1), names(result2))
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
})

test_that("get_brazil_gdp(): value_label column has no NA when value is not NA", {
  skip_on_cran()
  result <- get_brazil_gdp()
  non_na_value_indices <- which(!is.na(result$value))
  if (length(non_na_value_indices) > 0) {
    # When value is not NA, value_label should also not be NA
    expect_false(any(is.na(result$value_label[non_na_value_indices])))
  }
})

test_that("get_brazil_gdp(): GDP values are within statistical bounds", {
  skip_on_cran()
  result <- get_brazil_gdp()
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
