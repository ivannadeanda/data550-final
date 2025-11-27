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
	rm output/*.rds && rm -f output/*.png && rm -f *html