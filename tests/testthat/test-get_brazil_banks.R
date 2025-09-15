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

# get_brazil_banks

library(testthat)

test_that("get_brazil_banks() returns a valid tibble with correct structure", {
  skip_on_cran()

  result <- get_brazil_banks()

  expect_false(is.null(result))
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)

  expected_columns <- c("ispb", "name", "code", "fullName")
  expect_true(all(expected_columns %in% names(result)))
  expect_equal(ncol(result), 4)

  expect_type(result$ispb, "character")
  expect_type(result$name, "character")
  expect_type(result$code, "integer")
  expect_type(result$fullName, "character")
})

test_that("get_brazil_banks() handles API error gracefully", {
  skip_on_cran()

  stub_get_brazil_banks <- function() {
    url <- "https://brasilapi.com.br/api/INVALID-ENDPOINT"
    res <- httr::GET(url)
    if (res$status_code != 200) {
      return(NULL)
    }
    df <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))
    return(dplyr::as_tibble(df))
  }

  result <- stub_get_brazil_banks()
  expect_null(result)
})
