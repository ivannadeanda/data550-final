# Background on data
These data were acquired from GitHub user btbuIntelliSense. The dataset provides hourly temperature and humidity data for all of 2019 in Beijing. There is limited information on how these data were collected. The reason this dataset was chosen was so it can help me think through how to analyze my own thesis data involving temperature and humidity data for participants across Atlanta (which cannot be made publicly available for the purposes of this project).

# Contents
The original/raw data are contained in the 'raw_data' folder.
This repository contains all code in the 'code' folder, which are required for building tables and figures. 
All output (.rds and .png files) will be saved in the output folder. 

The code for generating the tables is in "code/01_summary_table.R"

The code for generating the figure is in "code/02_temp_figure.R"

# Renv Project Library
Prior to rendering the report, run 'make install' in the terminal to restore the package library.


# Rendering
To render the report, type 'make' in the terminal. 

To clean the directory of all output generated, type 'make clean' in the terminal.

Additional make commands can be found in the makefile. 