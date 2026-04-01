# jbi-risk-of-bias-traffic-light-plot
Reproducible R code and output files for a JBI-style risk-of-bias traffic light figure used in evidence synthesis and meta-analytic reporting.
# JBI Risk-of-Bias Traffic Light Plot

This repository contains reproducible R code, source data objects, and exported figure files for generating a JBI-style risk-of-bias traffic light plot.

## Overview

The materials in this repository were prepared to support transparent and reproducible reporting of risk-of-bias visualization in evidence synthesis and meta-analytic research. The repository includes the main R script used to generate the figure, the underlying data objects used during figure construction, the final exported outputs in PNG and PDF formats, and session information for computational reproducibility.

## Repository Contents

- `jbi-risk-of-bias-traffic-light-plot.R`  
  Main R script used to generate the figure.

- `jbi-risk-of-bias-traffic-light-plot.png`  
  PNG version of the final traffic light plot.

- `jbi-risk-of-bias-traffic-light-plot.pdf`  
  PDF version of the final traffic light plot.

- `domain_note.csv`  
  Data object containing domain note labels used in the figure.

- `left_header.csv`  
  Data object used for the left-side study labels.

- `legend_df.csv`  
  Data object used to construct the plot legend.

- `rob_dat.csv`  
  Data object containing study-level risk-of-bias judgments.

- `rob_long.csv`  
  Long-format data object used for plotting.

- `top_header.csv`  
  Data object used for the top header labels.

- `session_info.txt`  
  R session and package information for reproducibility.

## Reproducibility

The figure can be reproduced by running the R script in RStudio with the accompanying source files provided in this repository. The included session information file documents the computational environment used when preparing the figure.

## Purpose

This repository is intended as a supplementary reproducibility resource for methodological transparency and visual reporting of risk-of-bias assessment results.

## Author

Zhongrui Qiao  
PhD student in Psychology  
Lomonosov Moscow State University
