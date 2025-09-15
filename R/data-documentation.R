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


#' Brazilian Female Demographics & Mortality (1991-2000)
#'
#' This dataset, Brasil_females_df, is a data frame containing population counts and mortality information
#' for females in Brazil, disaggregated by federal states and abridged age groups, for the years 1991 and 2000.
#' The dataset includes 486 observations and 8 variables. Population counts are reported for both years,
#' and deaths are given as average counts over the intercensal period. Age groups follow the pattern 0, 1, 5, ..., 75,
#' with an open age group at 80+. A total of 53 Brazilian states are represented.
#'
#' The dataset name has been kept as 'Brasil_females_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name Brasil_females_df
#' @format A data frame with 486 observations and 8 variables:
#' \describe{
#'   \item{cod}{Integer code identifying each federal state}
#'   \item{pop1}{Population count in 1991 (integer)}
#'   \item{pop2}{Population count in 2000 (integer)}
#'   \item{deaths}{Average number of deaths during the intercensal period (numeric)}
#'   \item{year1}{First census year (1991; integer)}
#'   \item{year2}{Second census year (2000; integer)}
#'   \item{age}{Abridged age group (integer values like 0, 1, 5, ..., 75; open age group at 80)}
#'   \item{sex}{Sex identifier; all values are "f" (character)}
#' }
#' @source Data taken from the DDM package version 1.0-0
#' @usage data(Brasil_females_df)
#' @export
load("data/Brasil_females_df.rda")
NULL


#' Brazilian Male Demographics & Mortality (1980-1991)
#'
#' This dataset, Brasil_males_df, is a data frame containing population counts and mortality information
#' for males in Brazil, disaggregated by federal states and abridged age groups, for the years 1980 and 1991.
#' The dataset includes 486 observations and 8 variables. Population counts are reported for both years,
#' and deaths are given as average counts over the intercensal period. Age groups follow the pattern 0, 1, 5, ..., 75,
#' with an open age group at 80+. A total of 53 Brazilian states are represented.
#'
#' The dataset name has been kept as 'Brasil_males_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name Brasil_males_df
#' @format A data frame with 486 observations and 8 variables:
#' \describe{
#'   \item{cod}{Integer code identifying each federal state}
#'   \item{pop1}{Population count in 1980 (integer)}
#'   \item{pop2}{Population count in 1991 (integer)}
#'   \item{deaths}{Average number of deaths during the intercensal period (numeric)}
#'   \item{year1}{First census year (1980; integer)}
#'   \item{year2}{Second census year (1991; integer)}
#'   \item{age}{Abridged age group (integer values like 0, 1, 5, ..., 75; open age group at 80)}
#'   \item{sex}{Sex identifier; all values are "m" (character)}
#' }
#' @source Data taken from the DDM package version 1.0-0
#' @usage data(Brasil_males_df)
#' @export
load("data/Brasil_males_df.rda")
NULL


#' Films Shown at Brazilian Film Festivals (2007–2011)
#'
#' This dataset, Brazil_films_df, is a data frame containing information on films shown at five
#' different film festivals in Brazil from 2007 to 2011. The dataset includes 25 observations and 6 variables,
#' summarizing the number of films, directors, male and female directors, and regional categories for each year.
#'
#' The dataset name has been kept as 'Brazil_films_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name Brazil_films_df
#' @format A data frame with 25 observations and 6 variables:
#' \describe{
#'   \item{year}{Year of the film festival (integer)}
#'   \item{regE}{Festival region (factor with 5 levels)}
#'   \item{F}{Number of films shown (integer)}
#'   \item{D}{Number of directors (integer)}
#'   \item{MD}{Number of male directors (integer)}
#'   \item{WD}{Number of female directors (integer)}
#' }
#' @source Data taken from the bpca package version 1.3-6
#' @usage data(Brazil_films_df)
#' @export
load("data/Brazil_films_df.rda")
NULL



#' Monthly Average Heights of the Rio Negro at Manaus (1903–1992)
#'
#' This dataset, manaus_ts, is a univariate time series of monthly average river heights of the Rio Negro at Manaus.
#' The series contains 1080 observations spanning 90 years, from January 1903 to December 1992. Each value represents
#' the monthly average of the daily stages (heights) of the Rio Negro. Manaus is located 18 km upstream from the confluence
#' of the Rio Negro with the Amazon River, and due to the minimal slope and flatland affluents, the measurements can be considered
#' a good approximation of the water level at the confluence.
#'
#' The dataset name has been kept as 'manaus_ts' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'ts' indicates that the dataset is a time series object. The original content has not been modified
#' in any way.
#'
#' @name manaus_ts
#' @format A univariate time series of class \code{ts} with 1080 monthly observations from 1903 to 1992:
#' \describe{
#'   \item{values}{Monthly average river heights (numeric)}
#' }
#' @source Data taken from the boot package version 1.3-31
#' @usage data(manaus_ts)
#' @export
load("data/manaus_ts.rda")
NULL


#' Yellow Fever Outbreak in Brazil (Dec 2016 – May 2017)
#'
#' This dataset, Yellow_Fever_list, is a list object containing information on the flow of Yellow Fever
#' cases between five Brazilian states during the outbreak period from December 2016 to May 2017.
#' The data include epidemiological statistics such as the number of cases, population, dates of first and last
#' recorded cases, as well as travel-related matrices indicating disease importation and exportation.
#'
#' The dataset name has been kept as 'Yellow_Fever_list' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'list' indicates that the dataset is a list object. The original content has not been modified
#' in any way.
#'
#' @name Yellow_Fever_list
#' @format A list with 4 elements:
#' \describe{
#'   \item{states}{A data frame with 5 observations on 5 variables, including location code, population, number of cases, and dates of first and last reported cases}
#'   \item{T_D}{A 5x10 numeric matrix of travel destinations (disease importation probabilities)}
#'   \item{T_O}{A 5x10 numeric matrix of travel origins (disease exportation probabilities)}
#'   \item{length_of_stay}{A named numeric vector of average length of stay per destination}
#' }
#' @source Data taken from the epiflows package version 0.2.1
#' @usage data(Yellow_Fever_list)
#' @export
load("data/Yellow_Fever_list.rda")
NULL



#' Emission Factors from the Environmental Agency of São Paulo (CETESB)
#'
#' This dataset, sp_emission_factors_df, is a data frame containing emission factors from the Environmental
#' Agency of São Paulo (CETESB), including equivalencies with European (EURO) vehicle emission standards.
#' The dataset includes 288 observations and 10 variables, covering pollutants, vehicle age and type,
#' and classification systems such as Proconve and EURO for both light-duty and heavy-duty vehicles.
#'
#' The dataset name has been kept as 'sp_emission_factors_df' to avoid confusion with other datasets
#' in the R ecosystem. This naming convention helps distinguish this dataset as part of the
#' BrazilDataAPI package and assists users in identifying its specific characteristics.
#' The suffix 'df' indicates that the dataset is a data frame. The original content has not been modified
#' in any way.
#'
#' @name sp_emission_factors_df
#' @format A data frame with 288 observations and 10 variables:
#' \describe{
#'   \item{Age}{Vehicle age (integer)}
#'   \item{Year}{Reference year (integer)}
#'   \item{Pollutant}{Pollutant type (character)}
#'   \item{Proconve_LDV}{Proconve classification for light-duty vehicles (factor)}
#'   \item{t_Euro_LDV}{Temporal equivalence to EURO for light-duty vehicles (factor)}
#'   \item{Euro_LDV}{EURO standard classification for light-duty vehicles (factor)}
#'   \item{Proconve_HDV}{Proconve classification for heavy-duty vehicles (factor)}
#'   \item{Euro_HDV}{EURO standard classification for heavy-duty vehicles (factor)}
#'   \item{PC_G}{Emission factor (numeric)}
#'   \item{LT}{Lifetime or load factor (numeric)}
#' }
#' @source Data taken from the vein package version 1.1.3
#' @usage data(sp_emission_factors_df)
#' @export
load("data/sp_emission_factors_df.rda")
NULL


