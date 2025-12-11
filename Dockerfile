# Installing R using Rocker
FROM rocker/tidyverse:4.5.1

# Installing v8
RUN apt-get update && apt-get install -y \
  libv8-dev \
  libnode-dev \
  libicu-dev \
  libssl-dev \
  g++

# Making and setting working directory to 'project'
RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

# Making folders needed for initial output generation
RUN mkdir raw_data
RUN mkdir code
RUN mkdir output
RUN mkdir report

# Copying relevant files
COPY code code
COPY raw_data raw_data
COPY Makefile .
COPY final_data.Rmd .
COPY project_image .

# Copying relevant renv files
COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv 

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

# Restoring project library
RUN Rscript -e "renv::restore(prompt=FALSE)"

CMD make && mv toolkit_final_report.html report