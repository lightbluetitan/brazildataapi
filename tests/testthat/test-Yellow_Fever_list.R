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

# Yellow_Fever_list

library(testthat)

# Test 1: Confirm the object is a base R list
test_that("Yellow_Fever_list is a base R list", {
  expect_true(is.list(Yellow_Fever_list))
})

# Test 2: Confirm the list has exactly 4 named elements
test_that("Yellow_Fever_list has 4 named elements", {
  expect_equal(length(Yellow_Fever_list), 4)
  expect_false(is.null(names(Yellow_Fever_list)))
  expect_equal(sort(names(Yellow_Fever_list)), sort(c("states", "T_D", "T_O", "length_of_stay")))
})

# Test 3: Confirm the 'states' element is a data frame with 5 columns and 5 rows
test_that("Yellow_Fever_list$states is a data frame with correct dimensions", {
  expect_s3_class(Yellow_Fever_list$states, "data.frame")
  expect_equal(nrow(Yellow_Fever_list$states), 5)
  expect_equal(ncol(Yellow_Fever_list$states), 5)
})

# Test 4: Confirm 'T_D' and 'T_O' are numeric matrices 5x10
test_that("T_D and T_O are 5x10 numeric matrices", {
  expect_true(is.numeric(Yellow_Fever_list$T_D))
  expect_equal(dim(Yellow_Fever_list$T_D), c(5, 10))

  expect_true(is.numeric(Yellow_Fever_list$T_O))
  expect_equal(dim(Yellow_Fever_list$T_O), c(5, 10))
})

# Test 5: Confirm 'length_of_stay' is a named numeric vector of length 10
test_that("length_of_stay is a named numeric vector of length 10", {
  expect_type(Yellow_Fever_list$length_of_stay, "double")
  expect_equal(length(Yellow_Fever_list$length_of_stay), 10)
  expect_false(is.null(names(Yellow_Fever_list$length_of_stay)))
  expect_equal(length(names(Yellow_Fever_list$length_of_stay)), 10)
})

# Test 6: NA values are valid in all list elements
test_that("NA values are valid in Yellow_Fever_list elements", {
  expect_true(all(is.na(Yellow_Fever_list$T_D) | is.numeric(Yellow_Fever_list$T_D)))
  expect_true(all(is.na(Yellow_Fever_list$T_O) | is.numeric(Yellow_Fever_list$T_O)))
  expect_true(all(is.na(Yellow_Fever_list$length_of_stay) | is.numeric(Yellow_Fever_list$length_of_stay)))
  expect_true(is.data.frame(Yellow_Fever_list$states)) # No need to test NA here — accepted as valid
})
