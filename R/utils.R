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

  # Variables of the get_country_info function
  "name.common", "name.official", "capital", "region", "subregion", "population", "area", "languages"


))

utils::globalVariables(c("data"))
