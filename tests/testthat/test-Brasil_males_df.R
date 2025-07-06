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

# Brasil_males_df

library(testthat)

# Test 1: Confirm the object is a data frame
test_that("Brasil_males_df is a data frame", {
  expect_s3_class(Brasil_males_df, "data.frame")
})

# Test 2: Confirm it has exactly 8 columns
test_that("Brasil_males_df has 8 columns", {
  expect_equal(length(Brasil_males_df), 8)
})

# Test 3: Confirm it has exactly 486 rows
test_that("Brasil_males_df has 486 rows", {
  expect_equal(nrow(Brasil_males_df), 486)
})

# Test 4: Confirm column names are correct
test_that("Brasil_males_df has correct column names", {
  expect_named(Brasil_males_df, c(
    "cod", "pop1", "pop2", "deaths", "year1", "year2", "age", "sex"
  ))
})

# Test 5: Confirm column types are as expected
test_that("Brasil_males_df columns have correct types", {
  expect_type(Brasil_males_df$cod, "integer")
  expect_type(Brasil_males_df$pop1, "integer")
  expect_type(Brasil_males_df$pop2, "integer")
  expect_type(Brasil_males_df$deaths, "double")
  expect_type(Brasil_males_df$year1, "integer")
  expect_type(Brasil_males_df$year2, "integer")
  expect_type(Brasil_males_df$age, "integer")
  expect_type(Brasil_males_df$sex, "character")
})
