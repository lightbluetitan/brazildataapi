# BrazilDataAPI

The `BrazilDataAPI` package provides a unified interface to access open data from the **BrasilAPI**, **REST Countries API**, **Nager.Date API**, and **World Bank API**, with a focus on *Brazil*. It allows users to easily retrieve up-to-date information on postal codes, banks, economic indicators, holidays, company registrations, international country-level data, public holidays information, and economic development data relevant to *Brazil*.

In addition to API-access functions, the package includes a collection of curated datasets related to *Brazil*, covering diverse domains such as demographics (male and female population by state and year), river levels in *Manaus*, environmental emission factors in *São Paulo*, Brazilian film festivals, and historical yellow fever outbreaks.

## Installation

You can install the `BrazilDataAPI` package from CRAN with the following R function:

```R

install.packages("BrazilDataAPI")

```


## Usage

After installation, load the package and start exploring and using its functions and datasets.

```R

library(BrazilDataAPI)

```

### BrazilDataAPI Functions

- `get_brazil_banks()`: Get List of Banks in Brazil

- `get_brazil_cep()`: Get Address Information by Brazilian CEP (Postal Code) 
Example: *get_brazil_cep("89010025")* 

- `get_brazil_cnpj()`: Get Company Information by CNPJ (Brazil)
Example: *get_brazil_cnpj("19131243000197")*

- `get_brazil_municipalities()`: Get Municipalities of a Brazilian State from IBGE
Example: *get_brazil_municipalities("SP")*

- `get_brazil_rate_name()`: Get Specific Brazilian Economic Rate by Name
Example: *get_brazil_rate_name("CDI")*

- `get_brazil_rates()`: Get Official Interest Rates and Indexes from Brazil

- `get_brazil_vehicle_brands()`: Get Vehicle Brands from BrasilAPI (FIPE Data)
Example: *get_brazil_vehicle_brands("motos")*,*get_brazil_vehicle_brands("caminhoes")*

- `get_country_info()`: Get essential information about Brazil or any other country by its full name
Example: *get_country_info("Brazil")*,*get_country_info("brazil")*,*get_country_info("Peru")*

- `get_country_info_br()`: Get key country information for Brazil. 

- `get_brazil_child_mortality()`: Get Brazil’s Under-5 Mortality Rate data from the World Bank.

- `get_brazil_cpi()`: Get Brazil’s Consumer Price Index (2010 = 100) data from the World Bank.

- `get_brazil_energy_use()`: Get Brazil’s Energy Use (kg of oil equivalent per capita) data from the World Bank.

- `get_brazil_gdp()`: Get Brazil’s GDP (current US$) data from the World Bank.

- `get_brazil_hospital_beds()`: Get Brazil’s Hospital Beds (per 1,000 people) data from the World Bank.

- `get_brazil_life_expectancy()`: Get Brazil’s Life Expectancy at Birth data from the World Bank.

- `get_brazil_literacy_rate()`: Get Brazil’s Adult Literacy Rate data from the World Bank.

- `get_brazil_population()`: Get Brazil’s Total Population data from the World Bank.

- `get_brazil_unemployment()`: Get Brazil’s Total Unemployment Rate data from the World Bank.

- `get_brazil_holidays()`: Get official public holidays in Brazil for a given year, e.g., `get_brazil_holidays(2025)`.

- `view_datasets_BrazilDataAPI()`: Lists all curated datasets included in the `BrazilDataAPI` package


### Some of the BrazilDataAPI Datasets

The naming convention helps you easily understand the structure of each dataset:

- `_df`: A standard data frame.

- `_ts`: A time series object.

- `_list`: A list object.

- `Brasil_females_df`: Brazilian Female Demographics & Mortality
A data frame containing population counts and mortality information for females in Brazil, disaggregated by federal states and abridged age groups, for the years 1991 and 2000.

- `manaus_ts`: Monthly Average Heights of the Rio Negro at Manaus
A univariate time series of monthly average river heights of the Rio Negro at Manaus.
The series contains 1080 observations spanning 90 years, from January 1903 to December 1992.

- `Yellow_Fever_list`: Yellow Fever Outbreak in Brazil
A list object containing information on the flow of Yellow Fever cases between five Brazilian states during the outbreak period from December 2016 to May 2017.

## Example Code:

```R

# Load the package
library(BrazilDataAPI)

# Selected, essential information about Brazil
get_country_info_br()

# Get List of Banks in Brazil
get_brazil_banks()

# Load a dataset
data("Brasil_females_df")

# Shows six rows of the dataset
head(Brasil_females_df)

# Display the structure of the dataset
str(Brasil_females_df)

# Shows the whole dataset

View(Brasil_females_df)


```

