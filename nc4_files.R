
# Use this command in the R console to run this R code
# source(file="/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/r_code/nc4_files.R")

library(ncdf4)

nc_path <- "/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/nc_files/GLDAS"

nc_files <- list.files(path = nc_path, pattern = ".nc4", all.files = TRUE, full.name = TRUE)

nc_data_file <- nc_open(nc_files[1])
var_name_list <- names(nc_data_file$var)
print(head(var_name_list))
nc_data_combined <- data.frame(matrix(ncol = length(var_name_list), nrow = 0))
colnames(nc_data_combined) <- var_name_list
nc_close(nc_data_file)


get_nc_data <- function(nc_file) {
	
	print(paste("Extracting data from nc4 file: ", nc_file))
	
	nc_data <- nc_open(nc_file)
	on.exit(try(nc_close(nc_data), silent = TRUE), add = TRUE) 
	
	var_names <- names(nc_data$var)
	var_values <- list()

	for (v in var_names) {
		var_data <- ncvar_get(nc_data, v)
		
		if (dim(var_data)[1] == 360 && dim(var_data)[2] == 150) {
				if (!is.na(var_data[80,106])) {			
					var_values = append(var_values, var_data[80,106])
				}
				else {
					var_values = append(var_values, mean(var_data[78:82,104:108], na.rm = TRUE))
				}
		} 
		else {
			var_values = append(var_data[1], var_values)
		}
	}
	nc_close(nc_data)
	return(var_values)
}


for (nc_file in nc_files){
	var_value <- get_nc_data(nc_file)
	var_value_df <- as.data.frame(var_value, stringsAsFactors = FALSE)
	names(var_value_df) <- var_name_list
	nc_data_combined <- rbind(nc_data_combined, var_value_df)
}

nc_data_combined <- nc_data_combined %>% mutate(datetime = (as.POSIXct("2000-01-01 03:00:00", tz = "UTC") + time_bnds * 60), date = as.Date(datetime), time = format(datetime, format = "%H:%M:%S"))

nc_data_combined$year <- format(nc_data_combined$date, "%Y")
nc_data_combined$month <- format(nc_data_combined$date, "%b")

write.csv(nc_data_combined, "/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/nc_files/GLDAS_CLSM10_3H_2010_2014_combined_mandan_nd.csv", row.names = FALSE)

