# Background on data
These data were acquired from GitHub user btbuIntelliSense. The dataset provides hourly temperature and humidity data for all of 2019 in Beijing. There is limited information on how these data were collected. The reason this dataset was chosen was so it can help me think through how to analyze my own thesis data involving temperature and humidity data for participants across Atlanta (which cannot be made publicly available for the purposes of this project).

# Contents
The original/raw data are contained in the 'raw_data' folder.
This repository contains all code in the 'code' folder, which are required for building tables and figures. 
All output (.rds and .png files) will be saved in the output folder. 

The code for generating the tables is in "code/01_summary_table.R"

The code for generating the figure is in "code/02_temp_figure.R"

# Rendering from within Docker Container
## Renv Project Library
Prior to rendering the report, run 'make install' in the terminal to restore the package library.

## Rendering
To render the report, type 'make' in the terminal. 

To clean the directory of all output generated, type 'make clean' in the terminal.

Additional make commands can be found in the makefile. 

# Rendering from local machine
## Build image
To build Docker image from your machine, type 'make project_image' in the terminal

## Public Dockerhub Image
A Dockerhub image equipped to create this report from start to finish has been developed and can be found at: https://hub.docker.com/r/ivannadeanda/toolkit_final

## Running automated version of Dockerhub Image + rendering report
To run the ivannadeanda/toolkit_final Dockerhub image and automatically render the report, type one of the following two in your terminal:

For Windows users:
make docker_report_windows

For Mac users:
make docker_report_mac

Running the relevant command on your machine will set up a container based on the Dockerhub image ivannadeanda/toolkit_final, install any necessary packages, then run the code. The final report "toolkit_final_report.html" will be saved in the 'report' folder created in your working directory.