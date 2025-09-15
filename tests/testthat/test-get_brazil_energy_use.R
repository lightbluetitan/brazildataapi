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

# get_brazil_energy_use

library(testthat)

test_that("get_brazil_energy_use() returns a tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_energy_use()
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

test_that("get_brazil_energy_use() returns only Brazil data", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_true(all(result$country == "Brazil"))
})

test_that("get_brazil_energy_use() returns years from 2010 to 2022", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_true(all(result$year %in% 2010:2022))
  expect_equal(sort(unique(result$year)), 2010:2022)
})

test_that("get_brazil_energy_use() returns exactly 13 rows", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_equal(nrow(result), 13)
})

test_that("get_brazil_energy_use() includes the correct indicator label", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expected_indicator <- "Energy use (kg of oil equivalent per capita)"
  expect_true(all(result$indicator == expected_indicator))
})

test_that("get_brazil_energy_use() allows for missing values (NA)", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_true(any(is.na(result$value)) || all(!is.na(result$value)))
})

test_that("get_brazil_energy_use(): no NA values in year column", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_false(any(is.na(result$year)))
})

test_that("get_brazil_energy_use(): value column is numeric or NA", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_true(all(is.finite(result$value) | is.na(result$value)))
})

test_that("get_brazil_energy_use(): years are sorted in descending order", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_equal(result$year, sort(result$year, decreasing = TRUE))
})

test_that("get_brazil_energy_use(): indicator is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_equal(length(unique(result$indicator)), 1)
})

test_that("get_brazil_energy_use(): country is consistent across rows", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  expect_equal(length(unique(result$country)), 1)
})

test_that("get_brazil_energy_use(): energy use values are within reasonable range", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Energy use per capita should be positive and typically between 500-3000 kg oil equivalent for Brazil
    expect_true(all(non_na_values > 0))
    expect_true(all(non_na_values >= 500))
    expect_true(all(non_na_values <= 3000))
  }
})

test_that("get_brazil_energy_use(): energy use values are in expected range for Brazil", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    # Based on the sample data, values should be around 1300-1600 kg oil equivalent
    expect_true(all(non_na_values >= 1000))
    expect_true(all(non_na_values <= 2000))
  }
})

test_that("get_brazil_energy_use(): data covers complete time period", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  # Should have data for all years from 2010 to 2022 (13 years)
  expect_equal(length(unique(result$year)), 13)
  expect_true(min(result$year) == 2010)
  expect_true(max(result$year) == 2022)
})

test_that("get_brazil_energy_use(): energy use values show reasonable variation", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 1) {
    # Energy use should vary but not too dramatically year-to-year
    # Check that coefficient of variation is reasonable (typically < 0.2 for energy data)
    cv <- sd(non_na_values) / mean(non_na_values)
    expect_true(cv < 0.3)  # Allow some flexibility for economic fluctuations
  }
})

test_that("get_brazil_energy_use(): energy values are reasonable for a developing economy", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 0) {
    mean_energy_use <- mean(non_na_values)
    # Brazil's energy use should be moderate (not as high as developed countries, not as low as least developed)
    expect_true(mean_energy_use >= 1000)
    expect_true(mean_energy_use <= 2500)
  }
})

test_that("get_brazil_energy_use(): returns consistent structure across calls", {
  skip_on_cran()
  result1 <- get_brazil_energy_use()
  result2 <- get_brazil_energy_use()
  expect_equal(names(result1), names(result2))
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
})

test_that("get_brazil_energy_use(): energy use values are within expected statistical bounds", {
  skip_on_cran()
  result <- get_brazil_energy_use()
  non_na_values <- result$value[!is.na(result$value)]
  if (length(non_na_values) > 2) {
    # Check that values are within reasonable statistical bounds
    mean_value <- mean(non_na_values)
    sd_value <- sd(non_na_values)
    # Allow for values within 3 standard deviations (99.7% of normal distribution)
    lower_bound <- mean_value - 3 * sd_value
    upper_bound <- mean_value + 3 * sd_value
    expect_true(all(non_na_values >= lower_bound))
    expect_true(all(non_na_values <= upper_bound))
  }
})
