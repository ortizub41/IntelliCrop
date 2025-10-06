
# Use this command to run this R code
# source(file="/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/r_code/nasa_crop_analysis.R")

# Prepare NASA GLDAS data

nc_data_combined <- nc_data_combined %>% mutate(month = format(datetime, "%b"))
nc_data_combined <- nc_data_combined %>% mutate(year = format(datetime, "%Y"))
nc_data_combined <- nc_data_combined %>% filter(year != "2010")

nc_data_combined_preseason <- nc_data_combined %>% filter(month %in% c("Jan", "Feb", "Mar", "Apr"))
nc_data_combined_season <- nc_data_combined %>% filter(month %in% c("May", "Jun", "Jul", "Aug"))
nc_data_combined_postseason <- nc_data_combined %>% filter(month %in% c("Sep", "Oct", "Nov", "Dec"))

nc_data_combined_preseason_summary <- nc_data_combined_preseason %>% group_by(year) %>% summarize(across(-c(time_bnds, datetime, date, time, month), ~ mean(.x, na.rm = TRUE), .names = "mean_{.col}"))

nc_data_combined_season_summary <- nc_data_combined_season %>% group_by(year) %>% summarize(across(-c(time_bnds, datetime, date, time, month), ~ mean(.x, na.rm = TRUE), .names = "mean_{.col}"))

nc_data_combined_postseason_summary <- nc_data_combined_postseason %>% group_by(year) %>% summarize(across(-c(time_bnds, datetime, date, time, month), ~ mean(.x, na.rm = TRUE), .names = "mean_{.col}"))

# Prepare crop data

wheat_data_summary <- wheat_data %>% group_by(perennial_trt, year) %>% summarize(across(-c(rep, strip, field_stag_start, yr_in_perennial), ~ mean(.x, na.rm = TRUE), .names = "mean_{.col}"))
wheat_data_summary$year <- as.character(wheat_data_summary$year)
wheat_data_summary_trt <- wheat_data_summary %>% filter(perennial_trt == "MIX")

#unique(wheat_data_summary$perennial_trt)
#[1] "AFW"     "Alfalfa" "IWG"     "MIX" 


# Combine NASA and crop data

combined_nasa_wheat_data_preseason <- left_join(nc_data_combined_preseason_summary, wheat_data_summary_trt, by = "year")
combined_nasa_wheat_data_season <- inner_join(nc_data_combined_season_summary, wheat_data_summary_trt, by = "year")
combined_nasa_wheat_data_postseason <- inner_join(nc_data_combined_postseason_summary, wheat_data_summary_trt, by = "year")

# Linear Regression

gldas_vars_preseason <- setdiff(names(nc_data_combined_preseason_summary), c("time_bnds", "datetime", "date", "time", "month", "year"))
gldas_vars_season <- setdiff(names(nc_data_combined_season_summary), c("time_bnds", "datetime", "date", "time", "month", "year"))
gldas_vars_postseason <- setdiff(names(nc_data_combined_postseason_summary), c("time_bnds", "datetime", "date", "time", "month", "year"))

wheat_vars <- setdiff(names(wheat_data_summary), c("rep", "strip", "field_stag_start", "yr_in_perennial", "perennial_trt", "year"))


results_preseason <- purrr::map_dfr(wheat_vars, function(wheat_var) {
	purrr::map_df(gldas_vars_preseason, function(var) {
		print(paste("Analyzing GLDAS var ", var, " and wheat var ", wheat_var, " for pre-season"))
		
		var_dataset <- combined_nasa_wheat_data_preseason %>% select(var) %>% unique()
		
		if(nrow(as.data.frame(var_dataset)) > 1) {
		
  			f <- as.formula(paste(wheat_var," ~ ", var))
  			m <- lm(f, data = combined_nasa_wheat_data_preseason)
  			#print(summary(m)$coefficients[2,4])
  		
  			tibble(
  				wheat_variable = wheat_var,
    			variable = var,
    			estimate = coef(m)[2],
    			p_value = summary(m)$coefficients[2,4],
    			r_squared = summary(m)$r.squared
  			)
  		}
  		else {
  			print(paste("Unable to analyze ", var, " & ", wheat_var))
  			tibble::tibble()
  		}
	})
})



results_season <- purrr::map_dfr(wheat_vars, function(wheat_var) {
	purrr::map_df(gldas_vars_season, function(var) {
		print(paste("Analyzing GLDAS var ", var, " and wheat var ", wheat_var, " for season"))
		
		var_dataset <- combined_nasa_wheat_data_season %>% select(var) %>% unique()
		
		if(nrow(as.data.frame(var_dataset)) > 1) {
		
  			f <- as.formula(paste(wheat_var," ~ ", var))
  			m <- lm(f, data = combined_nasa_wheat_data_season)
  			#print(summary(m)$coefficients[2,4])
  		
  			tibble(
  				wheat_variable = wheat_var,
    			variable = var,
    			estimate = coef(m)[2],
    			p_value = summary(m)$coefficients[2,4],
    			r_squared = summary(m)$r.squared
  			)
  		}
  		else {
  			print(paste("Unable to analyze ", var, " & ", wheat_var))
  			tibble::tibble()
  		}
	})
})


results_postseason <-purrr::map_dfr(wheat_vars, function(wheat_var) {
	purrr::map_df(gldas_vars_postseason, function(var) {
		print(paste("Analyzing GLDAS var ", var, " and wheat var ", wheat_var, " for post-season"))
		
		var_dataset <- combined_nasa_wheat_data_postseason %>% select(var) %>% unique()
		
		if(nrow(as.data.frame(var_dataset)) > 1) {
		
  			f <- as.formula(paste(wheat_var," ~ ", var))
  			m <- lm(f, data = combined_nasa_wheat_data_postseason)
  			#print(summary(m)$coefficients[2,4])
  		
  			tibble(
  				wheat_variable = wheat_var,
    			variable = var,
    			estimate = coef(m)[2],
    			p_value = summary(m)$coefficients[2,4],
    			r_squared = summary(m)$r.squared
  			)
  		}
  		else {
  			print(paste("Unable to analyze ", var, " & ", wheat_var))
  			return(NULL)
  		}
	})
})

results_preseason <- results_preseason %>% arrange(p_value)
results_season <- results_season %>% arrange(p_value)
results_postseason <- results_postseason %>% arrange(p_value)

results_all <- dplyr::bind_rows(
  dplyr::mutate(results_preseason, season = "preseason"),
  dplyr::mutate(results_season, season = "season"),
  dplyr::mutate(results_postseason, season = "postseason")
)

write.csv(results_all, "/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/data/combined_nasa_wheat_df_mandan_nd.csv", row.names = FALSE)








