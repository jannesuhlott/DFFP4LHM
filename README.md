# DFFU Biodiversity
Author: Jannes Säurich ([ORCID: 0009-0003-4948-128X](https://orcid.org/0009-0003-4948-128X))

R Scripts for Data-Fitness-for-Purpose (DFFP) assessment during calculation of biodiversity metrics. 

# Repository Content
Workflows:
- [SWD_Workflow.Rmd](/Workflows/SWD_Workflow.Rmd) -> Workflow for calculation based on [Schwieder et. al (2022)](https://zenodo.org/records/10645427) (SWD) 
- [PRE_Workflow.Rmd](/Workflows/PRE_Workflow.Rmd) -> Workflow for calculation based on [Preidl et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub) (PRE)
- [IACS_Preparation.Rmd](/Workflows/IACS_Preparation.Rmd) -> Workflow for preparation of IACS Data

Functions: 
- [Functions_Metrics.R](/Functions/Functions_Metrics.R) -> Functions needed for metrcis calculation
- [Functions_CropTypes.R](/Functions/Functions_CropTypes.R) -> Functions for Crop Type aggregation

## Introduction
The code published here was developed for an exemplary assessment of data fitness for purpose in the context of biodiversity metrics.

In Germany, highly detailed datasets in the form of [IACS data (Integrated Administration and Control System)](https://agriculture.ec.europa.eu/common-agricultural-policy/financing-cap/assurance-and-audit/managing-payments_en) are generated as part of the process for agricultural subsidies. The responsibility for producing and publishing these data lies with the individual federal states, which handle public accessibility differently. While data from some states are publicly available, they cannot be utilized in others.

Within the [MonViA](https://www.agrarmonitoring-monvia.de/), the objective was to derive nationwide biodiversity metrics. Although IACS data provide high spatial and thematic accuracy, they were not available for a national-scale analysis. As an alternative, satellite-based crop type classifications were employed. These classifications rely on freely available Sentinel satellite data in Germany and have a spatial resolution of 10 × 10 m. Their comprehensive, nationwide coverage provided a compelling rationale for their use in our dataset. For this, data sets based on [Preid et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub) and [Blickensdörfer et al. (2022)](https://www.sciencedirect.com/science/article/pii/S0034425721005514) were used. The last one was updated by [Schwieder et. al (2022)](https://zenodo.org/records/10645427).

Within the framework of Data FAIRness, comparability of the different input data for the derivation of an exemplary biodiversity metric, the Shannon Evenness Index, was assessed. During this process, various data fitness-for-purpose metrics were determined. The methodology, analysis, and discussion of the results have been published in a scientific paper.

## Methods
Our analysis can be viewed as a two-stage process. In deriving the Shannon Evenness Index (SEI), operations are performed, which affect the data quality of the final product:
1. Since the number and characteristics of classes differ between IACS and the CTC, both CTC and IACS subsets are subject to class harmonisation operations. The resulting raster information is then transferred to the field polygons.
2. In the SEI derivation procedure, the filtered and harmonised crop type classes are spatially aggregated to reference units (hexagons). 

During the process multiple accuracy metrics were calculated. 

**Phase 1: Filtering and Harmonization**

*Table 1: Regional accuracy metrics on field scale. [+] IACS is validated by IACS, "/" proportions are calculated separately for each CTC variants and IACS*
| Name | Input scale | Input data | Metric| Output scale  | Output level |
| ---- | ----------- | ---------- |------ | ------------- | ------------ |
| Overall accuracy    | fields      | IACS + CTC | Overall accuracy per federal state after user specific changes | federal state | regional     |
| class accuracy      | fields      | IACS + CTC | Confusionsmatrix with class specific F1, M-F1, W-F1, UA, PA    | federal state | regional     |
| Proportions of area | fields      | IACS/ CTC  | Percentage of area per crop type                               | federal state | regional     |

*Table 2: Local accuracy metrics on field scale, [+] CTC is validated by IACS*
| Name        | Input scale | Input data | Metric | Output scale | Output level |
| ----------- | ----------- | ---------- | -------| ------------ | ------------ |
| Uncertainty | fields      | IACS + CTC | Differences of crop types between CTC and IACS classes per every field | field | local | 

**Phase 2: Spatial aggregation to hexagons**

*Table 3: Regional metrics for Data-Fitness-for-Purpose (DFFP) assessment on regional scale*
| Name                   | Input scale | Input data | Metric                                 | Output scale  | Output level |
| ---------------------- | ----------- | ---------- | -------------------------------------- | ------------- | ------------ |
| Biodiversity metrics   | fields      | IACS, CTC  | calculate  SEI as biodiversity metrics | hexagon       | local        |
| summarizing statistics | hexagons    | SEI        | mean, standard deviation               | federal state | regional     |
| Comparative metrics    | hexagons    | SEI        | R² and RMSE; ks-test                   | federal state | regional     |

*Table 4: Local metrics for Data-Fitness-for-Purpose (DFFP) assessment on regional scale*
| Metric | Input scale | Input data | Metric | Output scale | Output level |
| ----------- | ----------- | ----------------------------- | ----------------- | ------------ | ------------ |
| Uncertainty | fields | (local) uncertainty | (local) uncertainty per hexagon (area weighted mean) | hexagon | local|
| Difference  | hexagons    | SEI (based on CTC + ICAS) | difference of metric values (IACS - CTC) | hexagon | local |



## Roadmap
The repository contains several files: 

### IACS Preparation

This script performs the preprocessing of IACS (Integrated Administration and Control System) data for federal-state-level agricultural analyses. It includes geometry correction, unique ID creation, and removal of overlapping polygons. The data are cropped to federal-state boundaries and filtered to retain relevant land-use types, excluding specific grassland, fodder, woodland, fallow, and other non-crop areas. The workflow produces cleaned Shapefiles for each state and year, with calculated polygon areas, facilitating accurate spatial analyses of cropland distribution.
SWD_Codes_Mapping: Contains the mapping of IACS Codes to the defined crop types from [Schwieder et. al (2022)](https://zenodo.org/records/10645427)
PRE_Code_Mapping: Contains the mapping of IACS Codes to the defined crop types from [Preid et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub)
IACS_Codes_Names: Contains the names of all used IACS Codes.

### SWD Workflow
This script covers the derivation of the Shannon Evenness Index from the data of [Schwieder et. al (2022)](https://zenodo.org/records/10645427) and the IACS data. During the calculation, the metrics from phases 1 and 2 are derived. 

### PRE Workflow
This script covers the derivation of the Shannon Evenness Index from the data of [Preid et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub) and the IACS data. During the calculation, the metrics from phases 1 and 2 are derived. 

### Function_Metrics.R
Function script for landscape heterogeneity metric calculation, which contains: 
- get_polygon_area
- get_evenness_per_hexagon
- get_hexagon_filtered
- get_AccMetrics
- plot theme

### Functions_CropTypes.R
Function script for aggregation of crop types, which contains: 
- get_I4PRE_L3_codes
- get_I4PRE_L3_codes

## Data
tbd 
# License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
