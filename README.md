# DALT7014 Data Mining Classroom Demo

This repository contains a GitHub Action Workflow that performs a HTTP GET request on a URL, 
processes the data in R and writes the resulting data (in this case the number of forks of this repository) to a file.

It is on a scheduled job to run each week, but will also run every time a commit is pushed to the repository. 

To install and use the package `httr` in R the command `sudo apt-get install libcurl4-openssl-dev` must be ran first. 

`workflow.yml` calls a single r script `script.R` which first sources another script `require_packages.R`, this installs only if necessary R packages. 

`r-lib/actions/setup-renv@v2` is called to cache the R environment to save on installing libraries on every run of the workflow.

This schedules a weekly run of the solution to the [DALT7014 Week 4 Practical](https://skamper1.github.io/DALT7014_2023_2024_Data_Mining/week_04_practical.html#week-4-practical-solution)
