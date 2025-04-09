# RShiny for Volcano Plot Generator with Benchmarking (DuckDB vs dplyr)

This repository contains an R Shiny app for generating **volcano plots** from gene expression data, along with a performance comparison between **DuckDB** and **dplyr** for data processing. 

The csv is in long format from a wide table using melt function. The original dataset can be accessed in the supplemental section, Shen et al. Int. J. Mol. Sci. 2023, 24(4), 4033, https://doi.org/10.3390/ijms24044033. 

## Motivation

I didn't initially pay much attention to Shiny app performance, as the focus was primarily on functionality and user interface. However, inspired by the post, ["R Shiny and DuckDB: How to Speed Up Your Shiny Apps When Working With Large Datasets"](https://www.r-bloggers.com/2024/05/r-shiny-and-duckdb-how-to-speed-up-your-shiny-apps-when-working-with-large-datasets/), written by Dario Radečić, I decided to benchmark its performance within this small Shiny app to see how it compares to dplyr for processing large datasets.

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

DuckDB outperforms dplyr slightly in terms of runtime, 0.06 second faster or 7% improvement. 

** This project is an ongoing effort
