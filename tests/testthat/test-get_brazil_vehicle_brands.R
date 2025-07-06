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

# get_brazil_vehicle_brands

library(testthat)

testthat::test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'carros'", {
  result <- get_brazil_vehicle_brands("carros")
  testthat::expect_s3_class(result, "tbl_df")
  testthat::expect_true(all(c("nome", "valor") %in% names(result)))
})

testthat::test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'motos'", {
  result <- get_brazil_vehicle_brands("motos")
  testthat::expect_s3_class(result, "tbl_df")
  testthat::expect_true(all(c("nome", "valor") %in% names(result)))
})

testthat::test_that("get_brazil_vehicle_brands() returns a tibble with expected columns for 'caminhoes'", {
  result <- get_brazil_vehicle_brands("caminhoes")
  testthat::expect_s3_class(result, "tbl_df")
  testthat::expect_true(all(c("nome", "valor") %in% names(result)))
})

testthat::test_that("get_brazil_vehicle_brands() returns NULL for an invalid vehicle type", {
  result <- get_brazil_vehicle_brands("bicicletas")
  testthat::expect_null(result)
})

testthat::test_that("get_brazil_vehicle_brands() handles empty string input and returns a tibble with error message", {
  result <- get_brazil_vehicle_brands("")
  testthat::expect_s3_class(result, "tbl_df")
  testthat::expect_true(all(c("message") %in% names(result)) || all(c("nome", "valor") %in% names(result)))
})
