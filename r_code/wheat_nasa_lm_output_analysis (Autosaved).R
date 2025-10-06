
# import combined output of linear regression analysis between wheat vars and gldas vars

wheat_nasa_lm_output <- read.csv("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/non_raw_data_docs/data/combined_nasa_wheat_df_mandan_nd_all_perennial_trt.csv", head = TRUE)

# filter for statistically-significant outputs

wheat_nasa_lm_output_significant <- wheat_nasa_lm_output %>% filter(p_value < 0.05)

# summarize gldas vars that had the most number of significant influences on wheat vars

wheat_nasa_lm_output_significant_summary_nasa_positive <- wheat_nasa_lm_output_significant %>% filter(estimate > 0 & season != "postseason") %>% group_by(variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(desc(estimate_mean))

wheat_nasa_lm_output_significant_summary_nasa_negative <- wheat_nasa_lm_output_significant %>% filter(estimate < 0 & season != "postseason") %>% group_by(variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(desc(estimate_mean))

# summarize gldas vars that had the most number of significant influences on wheat vars by season

wheat_nasa_lm_output_significant_summary_nasa_positive_by_season <- wheat_nasa_lm_output_significant %>% filter(estimate > 0) %>% group_by(season, variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(season, desc(count))

wheat_nasa_lm_output_significant_summary_nasa_negative_by_season <- wheat_nasa_lm_output_significant %>% filter(estimate < 0) %>% group_by(season, variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(season, desc(count))


wheat_nasa_lm_output_significant_summary_nasa_positive_by_season <- wheat_nasa_lm_output_significant %>% filter(estimate > 0) %>% group_by(season, variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(season, desc(estimate_median))

wheat_nasa_lm_output_significant_summary_nasa_negative_by_season <- wheat_nasa_lm_output_significant %>% filter(estimate < 0) %>% group_by(season, variable) %>% summarize(count = n(), estimate_mean = mean(estimate), estimate_median = median(estimate)) %>% arrange(season, desc(estimate_median))







