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

# get_brazil_holidays

library(testthat)

test_that("get_brazil_holidays() returns tibble with correct structure and types", {
  skip_on_cran()
  result <- get_brazil_holidays(2025)

  # Structure
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("date", "local_name", "name"))
  expect_equal(ncol(result), 3)

  # Types
  expect_s3_class(result$date, "Date")
  expect_type(result$local_name, "character")
  expect_type(result$name, "character")

  # Should return at least one holiday
  expect_gt(nrow(result), 0)
})

test_that("get_brazil_holidays() dates belong to the requested year", {
  skip_on_cran()
  year <- 2025
  result <- get_brazil_holidays(year)
  expect_true(all(format(result$date, "%Y") == as.character(year)))
})

test_that("get_brazil_holidays() errors on invalid year inputs", {
  expect_error(get_brazil_holidays("not_a_year"))
  expect_error(get_brazil_holidays(999))   # Likely invalid year
  expect_error(get_brazil_holidays(3000))  # Too far in the future
})

test_that("get_brazil_holidays() returns consistent columns across calls", {
  skip_on_cran()
  res1 <- get_brazil_holidays(2024)
  res2 <- get_brazil_holidays(2025)
  expect_named(res1, c("date", "local_name", "name"))
  expect_named(res2, c("date", "local_name", "name"))
})

test_that("get_brazil_holidays() returns a reasonable number of holidays", {
  skip_on_cran()
  result <- get_brazil_holidays(2025)

  # Brazil has usually around 12–16 national holidays
  expect_true(nrow(result) >= 10)
  expect_true(nrow(result) <= 25)
})
