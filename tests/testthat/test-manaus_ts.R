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

# manaus_ts

library(testthat)

# Test 1: Confirm the object is a time series
test_that("manaus_ts is a time-series object", {
  expect_s3_class(manaus_ts, "ts")
})

# Test 2: Confirm it has 1080 observations
test_that("manaus_ts has 1080 observations", {
  expect_equal(length(manaus_ts), 1080)
})

# Test 3: Confirm time series starts in 1903 and ends in 1992
test_that("manaus_ts starts in 1903 and ends in 1992", {
  expect_equal(start(manaus_ts), c(1903, 1))
  expect_equal(end(manaus_ts), c(1992, 12))
})

# Test 4: Confirm frequency is monthly
test_that("manaus_ts has monthly frequency", {
  expect_equal(frequency(manaus_ts), 12)
})

# Test 5: Accept NA values as valid
test_that("manaus_ts allows NA values", {
  expect_true(all(is.na(manaus_ts) | is.numeric(manaus_ts)))
})

# Test 6: Confirm all values are numeric or NA
test_that("manaus_ts contains only numeric or NA values", {
  expect_true(is.numeric(manaus_ts))
})
