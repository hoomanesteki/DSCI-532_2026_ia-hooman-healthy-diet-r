# Global Cost of a Healthy Diet (R Shiny)

**Author:** Hooman Esteki
**Course:** DSCI 532 Individual Assignment, UBC MDS 2026

Deployed app: https://019cedac-9b39-3db8-3478-070e91a5f49a.share.connect.posit.cloud/

## Purpose

This is a Shiny for R dashboard that explores how much a nutritionally adequate diet costs across countries and regions from 2017 to 2022. All costs are reported in PPP-adjusted USD per day, using data from the FAO Cost and Affordability of a Healthy Diet indicators and World Bank country metadata.

The app re-implements the core functionality of the group project (DSCI-532 Group 29, which used Shiny for Python) in Shiny for R, as required by the individual assignment.

The main questions the dashboard helps answer:

- Which regions have the highest average healthy diet costs?
- How have those costs changed over time?
- How many countries fall into each cost tier?

## App Features

The sidebar has three input controls that filter the entire dashboard at once:

- Year range slider (2017 to 2024)
- Region dropdown (All regions or a specific one)
- Cost category dropdown (All, Low Cost, High Cost, etc.)
- Reset Filters button to return all inputs to their defaults

The main panel shows:

- Four KPI value boxes: number of countries, average cost per day, minimum cost, and maximum cost
- A horizontal bar chart of average diet cost by region
- A line trend chart showing how average costs changed year over year per region
- An interactive data table with search, sort, and pagination

All outputs react to the reactive calculation that filters the dataset based on the three inputs.

## How to Install Packages and Run Locally

You need R version 4.1.0 or higher.

**Step 1: Clone the repository**

```bash
git clone https://github.com/hoomanesteki/DSCI-532_2026_ia-hooman-healthy-diet-r.git
cd DSCI-532_2026_ia-hooman-healthy-diet-r
```

**Step 2: Install required packages**

Open R or RStudio in the project folder and run:

```r
install.packages(c("shiny", "bslib", "dplyr", "ggplot2", "DT", "readr", "scales"))
```

**Step 3: Run the app**

```r
shiny::runApp()
```

Or open `app.R` in RStudio and click the **Run App** button at the top of the editor.

## How to Deploy to Posit Connect Cloud

This app is deployed via GitHub integration on Posit Connect Cloud. The `manifest.json` file in the repo handles all dependency resolution automatically.

To redeploy or deploy your own copy:

1. Go to https://connect.posit.cloud and sign in
2. Click Publish, select Shiny, then connect your GitHub repo
3. Set branch to `main` and primary file to `app.R`
4. Click Deploy

For more detail on R dependency files for Connect Cloud, see: https://docs.posit.co/connect-cloud/how-to/r/dependencies.html

## Data

The dataset `data/cleaned_price_of_healthy_diet.csv` covers roughly 170 countries across multiple years. It was derived from the FAO Cost and Affordability of a Healthy Diet indicators joined with World Bank country and region metadata. Costs are in PPP-adjusted USD per day.

## Project Structure

```
DSCI-532_2026_ia-hooman-healthy-diet-r/
   app.R                                    main Shiny for R application
   DESCRIPTION                              R package dependency list
   manifest.json                            Posit Connect Cloud deployment manifest
   README.md                                this file
   renv.lock                                renv lockfile with pinned package versions
   data/
      cleaned_price_of_healthy_diet.csv     processed dataset
```