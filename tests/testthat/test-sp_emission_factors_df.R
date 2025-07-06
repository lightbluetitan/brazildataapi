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

# sp_emission_factors_df

library(testthat)

# Test 1: Confirm the object is a data frame
test_that("sp_emission_factors_df is a data frame", {
  expect_s3_class(sp_emission_factors_df, "data.frame")
})

# Test 2: Confirm it has exactly 10 columns
test_that("sp_emission_factors_df has 10 columns", {
  expect_equal(length(sp_emission_factors_df), 10)
})

# Test 3: Confirm it has exactly 288 rows
test_that("sp_emission_factors_df has 288 rows", {
  expect_equal(nrow(sp_emission_factors_df), 288)
})

# Test 4: Confirm column names are correct
test_that("sp_emission_factors_df has correct column names", {
  expect_named(sp_emission_factors_df, c(
    "Age", "Year", "Pollutant", "Proconve_LDV", "t_Euro_LDV",
    "Euro_LDV", "Proconve_HDV", "Euro_HDV", "PC_G", "LT"
  ))
})

# Test 5: Confirm column types are as expected
test_that("sp_emission_factors_df columns have correct types", {
  expect_type(sp_emission_factors_df$Age, "integer")
  expect_type(sp_emission_factors_df$Year, "integer")
  expect_type(sp_emission_factors_df$Pollutant, "character")
  expect_s3_class(sp_emission_factors_df$Proconve_LDV, "factor")
  expect_s3_class(sp_emission_factors_df$t_Euro_LDV, "factor")
  expect_s3_class(sp_emission_factors_df$Euro_LDV, "factor")
  expect_s3_class(sp_emission_factors_df$Proconve_HDV, "factor")
  expect_s3_class(sp_emission_factors_df$Euro_HDV, "factor")
  expect_type(sp_emission_factors_df$PC_G, "double")
  expect_type(sp_emission_factors_df$LT, "double")
})
