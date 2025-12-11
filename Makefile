### REPORT-ASSOCIATED RULES ### (Run within docker container)
toolkit_final_report.html: code/render_report.R final_data.Rmd \
  clean_data make_tables make_figure
	Rscript code/render_report.R

.PHONY: clean_data	
clean_data: code/00_clean_data.R raw_data/beijing.csv
	Rscript code/00_clean_data.R

.PHONY: make_tables
make_tables: code/01_summary_table.R output/summer_evening_night_data.rds
	Rscript code/01_summary_table.R
	
.PHONY: make_figure
make_figure: code/02_temp_figure.R output/nighttime_hourly.rds
	Rscript code/02_temp_figure.R
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

.PHONY: clean
clean:
	rm output/*.rds && rm -f output/*.png && rm -f *html && rm report/*.html
	
### DOCKER-ASSOCIATED RULES ### (Run on our local machine)

PROJECTFILES = final_data.Rmd code/00_clean_data.R code/01_summary_table.R \
	code/02_temp_figure.R code/render_report.R Makefile
	
RENVFILES = renv.lock renv/activate.R renv/settings.json	

# Rule to build image
project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t toolkit_final .
	touch $@
	
# Rule to run container in either windows or mac
.PHONY: docker_report_windows
docker_report_windows:
	docker run -v "/$$(pwd)/report":/home/rstudio/project/report ivannadeanda/toolkit_final

.PHONY: docker_report_mac
docker_report_mac:
	docker run -v "$$(pwd)/report":/home/rstudio/project/report ivannadeanda/toolkit_final
