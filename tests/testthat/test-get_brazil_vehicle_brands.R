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

# get_brazil_vehicle_brands

library(testthat)

test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'carros'", {
  skip_on_cran()
  skip_if_offline()
  result <- get_brazil_vehicle_brands("carros")
  expect_s3_class(result, "tbl_df")
  expect_true(all(c("nome", "valor") %in% names(result)))
})

test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'motos'", {
  skip_on_cran()
  skip_if_offline()
  result <- get_brazil_vehicle_brands("motos")
  expect_s3_class(result, "tbl_df")
  expect_true(all(c("nome", "valor") %in% names(result)))
})

test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'caminhoes'", {
  skip_on_cran()
  skip_if_offline()
  result <- get_brazil_vehicle_brands("caminhoes")
  expect_s3_class(result, "tbl_df")
  expect_true(all(c("nome", "valor") %in% names(result)))
})

test_that("get_brazil_vehicle_brands() returns NULL for an invalid vehicle type", {
  skip_on_cran()
  skip_if_offline()
  result <- get_brazil_vehicle_brands("bicicletas")
  expect_null(result)
})

test_that("get_brazil_vehicle_brands() handles empty string input gracefully", {
  skip_on_cran()
  skip_if_offline()
  result <- get_brazil_vehicle_brands("")
  if (!is.null(result)) {
    expect_s3_class(result, "tbl_df")
    expect_true(
      all(c("message") %in% names(result)) ||
        all(c("nome", "valor") %in% names(result))
    )
  } else {
    succeed("Returned NULL as expected when input is empty")
  }
})
