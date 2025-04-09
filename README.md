

# RShiny for Volcano Plot Generator with Benchmarking (DuckDB vs dplyr)

This repository contains an R Shiny app for generating **volcano plots** from gene expression data, along with a performance comparison between **DuckDB** and **dplyr** for data processing. The app allows you to upload a CSV file, choose groups for comparison, and run statistical tests. It logs the runtime of each analysis and compares performance between DuckDB and dplyr.

## Motivation

I didn't initially pay much attention to Shiny app performance, as the focus was primarily on functionality and user interface. However, after recently reading a post titled ["R Shiny and DuckDB: How to Speed Up Your Shiny Apps When Working With Large Datasets"](https://www.r-bloggers.com/2024/05/r-shiny-and-duckdb-how-to-speed-up-your-shiny-apps-when-working-with-large-datasets/), written by Dario Radečić, I became intrigued to try DuckDB's potential to improve data processing performance.Inspired by the post, I decided to benchmark its performance within a small Shiny app to see how it compares to dplyr for processing large datasets.

## Features

- **Upload a CSV**: Upload your gene expression data in CSV long format.
- **Group Selection**: Choose a reference group and one or more comparison groups.
- **Statistical Testing**: Select between a t-test or Welch ANOVA.
- **Volcano Plot**: Visualize results with a volcano plot.
- **Runtime Logging**: Track and compare runtime for each analysis.
- **Performance Benchmarking**: Track performance between **DuckDB** and **dplyr** for data processing.

## Performance Benchmarking
This project compares the runtime performance of DuckDB and dplyr for processing gene expression data. Below are the screenshots showing the comparison of runtimes:

### dplyr Performance
This graph shows the performance of `dplyr` for processing the data.

### duckbd Performance
This graph shows the performance of `DuckDB` for processing the data.

### Average Runtime Comparison
After running the analysis multiple times, the average runtime for each approach is:

- DuckDB: 0.83 seconds

- dplyr: 0.89 seconds

DuckDB outperforms dplyr slightly in terms of runtime, 0.06 second faster or 7% improvement 
