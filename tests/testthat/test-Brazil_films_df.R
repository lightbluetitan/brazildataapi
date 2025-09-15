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

# Brazil_films_df

library(testthat)

# Test 1: Confirm the object is a data frame
test_that("Brazil_films_df is a data frame", {
  expect_s3_class(Brazil_films_df, "data.frame")
})

# Test 2: Confirm it has exactly 6 columns
test_that("Brazil_films_df has 6 columns", {
  expect_equal(length(Brazil_films_df), 6)
})

# Test 3: Confirm it has exactly 25 rows
test_that("Brazil_films_df has 25 rows", {
  expect_equal(nrow(Brazil_films_df), 25)
})

# Test 4: Confirm column names are correct
test_that("Brazil_films_df has correct column names", {
  expect_named(Brazil_films_df, c(
    "year", "regE", "F", "D", "MD", "WD"
  ))
})

# Test 5: Confirm column types are as expected
test_that("Brazil_films_df columns have correct types", {
  expect_type(Brazil_films_df$year, "integer")
  expect_s3_class(Brazil_films_df$regE, "factor")
  expect_type(Brazil_films_df$F, "integer")
  expect_type(Brazil_films_df$D, "integer")
  expect_type(Brazil_films_df$MD, "integer")
  expect_type(Brazil_films_df$WD, "integer")
})
