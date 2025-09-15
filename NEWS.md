# BrazilDataAPI 0.2.0

## Breaking Changes

- `get_country_info()` was renamed to `get_country_info_br()` to avoid naming conflicts with other packages and improve function identification.

The following APIs were added to the `BrazilDataAPI` package:

- **Nager.Date** <https://date.nager.at/Api>.

- **World Bank API** <https://datahelpdesk.worldbank.org/knowledgebase/articles/889392>

The following functions were added to the `BrazilDataAPI` package:

- `get_brazil_child_mortality()`: Get Brazil’s Under-5 Mortality Rate data from the World Bank.

- `get_brazil_cpi()`: Get Brazil’s Consumer Price Index (2010 = 100) data from the World Bank.

- `get_brazil_energy_use()`: Get Brazil’s Energy Use (kg of oil equivalent per capita) data from the World Bank.

- `get_brazil_gdp()`: Get Brazil’s GDP (current US$) data from the World Bank.

- `get_brazil_hospital_beds()`: Get Brazil’s Hospital Beds (per 1,000 people) data from the World Bank.

- `get_brazil_life_expectancy()`: Get Brazil’s Life Expectancy at Birth data from the World Bank.

- `get_brazil_literacy_rate()`: Get Brazil’s Adult Literacy Rate data from the World Bank.

- `get_brazil_population()`: Get Brazil’s Total Population data from the World Bank.

- `get_brazil_unemployment()`: Get Brazil’s Total Unemployment Rate data from the World Bank.

- `get_brazil_holidays()`: Get official public holidays in Brazil for a given year.

---

# BrazilDataAPI 0.1.0

## Initial Release

- First release of `BrazilDataAPI` package.
- Added `view_datasets_BrazilDataAPI()` function to explore available datasets.
- Curated Collection of datasets that cover diverse aspects of Brazilian society.
- Initial APIs *BrasilAPI* and *REST Countries API* – Added functions powered by these APIs
