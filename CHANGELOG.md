# CHANGELOG

All notable changes to this project will be documented in this file.

The format follows semantic versioning (MAJOR.MINOR.PATCH).

## [1.0.0] - 2026-03-14

### Added

- Initial release of the Shiny for R individual assignment re-implementation
- `app.R` with full Shiny for R dashboard using `bslib`, `ggplot2`, `DT`, `dplyr`, `readr`, and `scales`
- Year range slider input (2017 to 2024) that filters all outputs
- Region dropdown to narrow the dataset to a specific world region
- Cost category dropdown to filter by Low Cost, High Cost, or All
- Reset Filters button to restore all three inputs to their defaults in one click
- Reactive calc (`filtered()`) that applies all three filters to the dataset and drives every output
- Four KPI value boxes: number of countries, average cost per day, minimum cost per day, and maximum cost per day
- Bar chart of average daily diet cost by region, sorted ascending with dollar labels on each bar
- Line trend chart of average cost over time broken down by region, with labeled axes
- Interactive data table with search, sort, pagination, and formatted currency column
- `data/cleaned_price_of_healthy_diet.csv` with ~1380 rows covering roughly 170 countries
- `DESCRIPTION` file listing all R package dependencies
- `renv.lock` with pinned package versions for reproducibility
- `manifest.json` for Posit Connect Cloud deployment via GitHub integration
- `README.md` with app purpose, install instructions, run instructions, and deployed URL
- `CONTRIBUTING.md` with bug reporting and pull request guidelines using GitHub issues
- `CODE_OF_CONDUCT.md` adapted from the Contributor Covenant version 2.0
- `LICENSE` file
- `.gitignore` for R project files

### Notes

- This app re-implements the core functionality of DSCI-532 Group 29 (Shiny for Python) in Shiny for R, as required by the individual assignment
- Deployed at https://019cedac-9b39-3db8-3478-070e91a5f49a.share.connect.posit.cloud/
