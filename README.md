# Background on data
These data were acquired from GitHub user btbuIntelliSense. The dataset provides hourly temperature and humidity data for all of 2019 in Beijing. There is limited information on how these data were collected. The reason this dataset was chosen was so it can help me think through how to analyze my own thesis data involving temperature and humidity data for participants across Atlanta (which cannot be made publicly available for the purposes of this project).

# Contents
The original/raw data are contained in the 'raw_data' folder.
This repository contains all code in the 'code' folder, which are required for building tables and figures. 
All output (.rds and .png files) will be saved in the output folder.

## Brief description of code

`code/00_clean_data.R`
* Cleans and transforms raw data from raw_data/beijing.csv
* Saves clean data as summer_evening_night_data.rds and nighttime_hourly.rds in /output folder.

`code/01_summary_table.R`
* Reads in summer evening night data from output/summer_evening_night_data.rds
* Generates summary table of Nighttime Temperature and Humidity in Beijing (May-September 2019)
* Saves table as monthly_summary_table.rds in /output folder

`code/02_temp_figure.R`
* Reads in nighttime hourly data from output/nighttime_hourly.rds
* Generates graph on Average Nighttime Temperature by Hour (6 PM–6 AM)
* Saves figure as temp_figure.png in /output folder

`final_data.Rmd`
* Reads in the summary table from output/monthly_summary_table.rds and temperature figure from output/temp_figure.png
* Provides additional context for data, to be included in final report

`code/render_report.R`
* Renders final_data.Rmd, creating the final html report

# Rendering from within Docker Container
## Rendering

Prior to rendering the report, run `make install` in the terminal to restore the package library.

To render the report, type `make` in the terminal. 

To clean the directory of all output generated, type `make clean` in the terminal.

Additional make commands can be found in the makefile. 

# Rendering from local machine
## Build image
To build Docker image from your machine, type `make project_image` in the terminal. NOTE: this should not be necessary for automatically rendering report. Refer to the Windows/Mac make rules below for automatic report generation. 

## Public Dockerhub Image
A Dockerhub image equipped to create this report from start to finish can be found [here](https://hub.docker.com/r/ivannadeanda/toolkit_final).

## Running automated version of Dockerhub Image + rendering report
To run the ivannadeanda/toolkit_final Dockerhub image and automatically render the report, first ensure you are in the working directory for this project (contains Dockerfile). Then type one of the following two in your terminal:

For Windows users:
```
make docker_report_windows
```

For Mac users:
```
make docker_report_mac
```

Running the relevant command on your machine will set up a container based on the Dockerhub image ivannadeanda/toolkit_final, install any necessary packages, then run the code. The final report "toolkit_final_report.html" will be saved in the 'report' folder created in your working directory.