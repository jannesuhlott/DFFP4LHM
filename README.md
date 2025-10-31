# DFFU Biodiversity
[Jannes Säurich](https://orcid.org/0009-0003-4948-128X)

## Introduction
The code published here was developed for an exemplary assessment of data fitness for purpose in the context of biodiversity metrics.

In Germany, highly detailed datasets in the form of [IACS data (Integrated Administration and Control System)](https://agriculture.ec.europa.eu/common-agricultural-policy/financing-cap/assurance-and-audit/managing-payments_en) are generated as part of the process for agricultural subsidies. The responsibility for producing and publishing these data lies with the individual federal states, which handle public accessibility differently. While data from some states are publicly available, they cannot be utilized in others.

Within the [MonViA](https://www.agrarmonitoring-monvia.de/), the objective was to derive nationwide biodiversity metrics. Although IACS data provide high spatial and thematic accuracy, they were not available for a national-scale analysis. As an alternative, satellite-based crop type classifications were employed. These classifications rely on freely available Sentinel satellite data in Germany and have a spatial resolution of 10 × 10 m. Their comprehensive, nationwide coverage provided a compelling rationale for their use in our dataset. For this, data sets based on [Preid et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub) and [Blickensdörfer et al. (2022)](https://www.sciencedirect.com/science/article/pii/S0034425721005514) were used. The last one was updated by [Schwieder et. al (2022)](https://zenodo.org/records/10645427).

Within the framework of Data FAIRness, comparability of the different input data for the derivation of an exemplary biodiversity metric, the Shannon Evenness Index, was assessed. During this process, various data fitness-for-purpose metrics were determined. The methodology, analysis, and discussion of the results have been published in a scientific paper.

## Methode


## Roadmap
The repository contains several files: 

### IACS Preparation

This script performs the preprocessing of IACS (Integrated Administration and Control System) data for federal-state-level agricultural analyses. It includes geometry correction, unique ID creation, and removal of overlapping polygons. The data are cropped to federal-state boundaries and filtered to retain relevant land-use types, excluding specific grassland, fodder, woodland, fallow, and other non-crop areas. The workflow produces cleaned Shapefiles for each state and year, with calculated polygon areas, facilitating accurate spatial analyses of cropland distribution.
SWD_Codes_Mapping: Contains the mapping of IACS Codes to the defined crop types from [Schwieder et. al (2022)](https://zenodo.org/records/10645427)
PRE_Code_Mapping: Contains the mapping of IACS Codes to the defined crop types from [Preid et. al (2020)](https://www.sciencedirect.com/science/article/pii/S0034425720300420?via%3Dihub)
IACS_Codes_Names: Contains the names of all used IACS Codes.

## License
