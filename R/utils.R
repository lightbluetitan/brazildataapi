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

# utils.R


utils::globalVariables(c(


  # Variables of the get_brazil_banks function

  "ispb","name","code","fullName",

  # Variables of the get_brazil_cep function

  "cep","state","city","neighborhood","street","service",

  # Variables of the get_brazil_cnpj function

  "cnpj","razao_social","nome_fantasia","capital_social","data_inicio_atividade","cnae_fiscal_descricao","natureza_juridica","descricao_situacao_cadastral","municipio","uf","cep","logradouro","numero","bairro",

  # Variables of the get_brazil_municipalities function
  "nome","codigo_ibge",

  # Variables of the get_brazil_rate_name function
  "nome","valor",

  # Variables of the get_brazil_rates function
  "nome","valor",

  # Variables of the get_brazil_vehicle_brands function
  "nome","valor",

  # Variables of the get_country_info_br function
  "name_common", "name_official", "region", "subregion", "capital", "area", "population", "languages",

  # Variables of the get_brazil_child_mortality function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_cpi function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_energy_use function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_gdp function
  "indicator", "country", "year", "value", "value_label",

  # Variables of the get_brazil_hospital_beds function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_life_expectancy function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_literacy_rate function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_population function
  "indicator", "country", "year", "value", "value_label",

  # Variables of the get_brazil_unemployment function
  "indicator", "country", "year", "value",

  # Variables of the get_brazil_holidays function
  "date", "local_name", "name"



))

utils::globalVariables(c("data"))
