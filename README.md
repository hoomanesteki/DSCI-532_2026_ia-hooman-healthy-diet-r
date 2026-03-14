# Global Cost of a Healthy Diet (R Shiny)

**Author:** Hooman Esteki

A Shiny for R dashboard that explores the global cost of a healthy diet across countries and regions from 2017 to 2022. Data comes from the FAO and World Bank, with costs reported in PPP-adjusted USD per day.

Deployed app: [Add your Posit Connect Cloud URL here after deploying]

## Purpose

This dashboard lets you filter the dataset by year range, world region, and cost category to understand how much a nutritionally adequate diet costs in different parts of the world. The key questions it addresses are:

- Which regions have the most expensive healthy diets?
- How have costs changed over time?
- How many countries fall into each cost tier?

The app re-implements the core functionality of the group project (DSCI-532 Group 29) using Shiny for R instead of Shiny for Python.

## Features

- Year range slider to narrow down the time window
- Region and cost category dropdowns that filter all outputs at once
- Four KPI cards showing the number of countries, average cost, minimum cost, and maximum cost
- A bar chart of average daily diet cost by region
- A line trend chart showing how average costs have changed year over year per region
- An interactive data table with pagination and search

## Prerequisites

- R version 4.1.0 or higher
- An internet connection the first time you run (to download Google Fonts via `bslib`)

## Install Packages

Open R or RStudio and run:

```r
install.packages(c("shiny", "bslib", "dplyr", "ggplot2", "DT", "readr", "scales"))
```

## Run the App Locally

Clone this repository and navigate into the project folder, then run:

```r
shiny::runApp()
```

Or open `app.R` in RStudio and click the **Run App** button.

## Deploying to Posit Connect Cloud

1. Install the rsconnect package if you do not have it yet:

```r
install.packages("rsconnect")
```

2. Set up your Posit Connect Cloud account at https://connect.posit.cloud and copy your API key.

3. Authenticate from R:

```r
rsconnect::setAccountInfo(
  name   = "your-account-name",
  token  = "your-token",
  secret = "your-secret"
)
```

4. Deploy:

```r
rsconnect::deployApp(appName = "healthy-diet-r")
```

After deploying, paste the live URL into the GitHub repo About section and replace the placeholder link at the top of this README.

For the dependency file approach using renv, follow the instructions at: https://docs.posit.co/connect-cloud/how-to/r/dependencies.html

## Data

The dataset `data/cleaned_price_of_healthy_diet.csv` is derived from the FAO Cost and Affordability of a Healthy Diet indicators, joined with World Bank country metadata. It covers roughly 170 countries across multiple years.

## Project Structure

```
healthy-diet-r/
   app.R                              main Shiny app
   DESCRIPTION                        package dependency list for deployment
   README.md                          this file
   data/
      cleaned_price_of_healthy_diet.csv   processed dataset
```
