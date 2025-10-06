
# Use this command in the R console to run this script
# source(file="/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/r_code/nc4_data_plots.R")


# Import dataframe


wheat_data <- read.csv("/Users/gaellemuller-greven/Dropbox/data_science/projects/nasa_space_apps_2025/data/crop_data/PFAC_2011_2014_grain_mineral_protein_mandan_northdakota_df.csv", head = TRUE)


nc_data_combined$month <- factor(nc_data_combined$month, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), labels = c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"))

nc_data_combined %>% ggplot(aes(x = month, y = Wind_f_inst)) + geom_boxplot() + facet_wrap(~ year, scales = "free", ncol = 5)

nc_data_combined %>% ggplot(aes(x = month, y = SnowDepth_inst)) + geom_boxplot() + facet_wrap(~ year, scales = "free", ncol = 5)


nc_data_combined %>% ggplot(aes(x = month, y = Evap_tavg)) + geom_boxplot() + facet_wrap(~ year, scales = "free_x", ncol = 5) + labs(x = "Month", y = "Evapotranspiration (Kg/m2s) in Mandan, ND") + theme_classic() + theme(plot.title = element_text(size = 14), legend.key.size = unit(1,"line"), axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 11, angle = 90, vjust = .5), axis.title.y = element_text(size = 15), axis.title.x = element_text(size = 16), legend.title = element_text(size = 16), legend.text = element_text(size = 14), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), strip.text.x = element_text(size = 14), strip.background = element_rect(color = "black", fill = "white", size = 1, linetype = "solid"), panel.border = element_rect(color = "black", fill = NA, linewidth = 1))

nc_data_combined %>% ggplot(aes(x = month, y = Psurf_f_inst)) + geom_boxplot() + facet_wrap(~ year, scales = "free_x", ncol = 5) + labs(x = "Month", y = "Pressure (Pa) in Mandan, ND") + theme_classic() + theme(plot.title = element_text(size = 14), legend.key.size = unit(1,"line"), axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 11, angle = 90, vjust = .5), axis.title.y = element_text(size = 15), axis.title.x = element_text(size = 16), legend.title = element_text(size = 16), legend.text = element_text(size = 14), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), strip.text.x = element_text(size = 14), strip.background = element_rect(color = "black", fill = "white", size = 1, linetype = "solid"), panel.border = element_rect(color = "black", fill = NA, linewidth = 1))

nc_data_combined %>% ggplot(aes(x = month, y = SnowDepth_inst)) + geom_boxplot() + facet_wrap(~ year, scales = "free_x", ncol = 5) + labs(x = "Month", y = "Snow depth (m) in Mandan, ND") + theme_classic() + theme(plot.title = element_text(size = 14), legend.key.size = unit(1,"line"), axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 11, angle = 90, vjust = .5), axis.title.y = element_text(size = 15), axis.title.x = element_text(size = 16), legend.title = element_text(size = 16), legend.text = element_text(size = 14), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), strip.text.x = element_text(size = 14), strip.background = element_rect(color = "black", fill = "white", size = 1, linetype = "solid"), panel.border = element_rect(color = "black", fill = NA, linewidth = 1))

wheat_data %>% ggplot(aes(x = factor(year), y = ca)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = fe)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = protein)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = k)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = mg)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = mn)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)
wheat_data %>% ggplot(aes(x = factor(year), y = zn)) + geom_boxplot(outlier.shape = NA) + geom_point(position = position_jitter(height = 0, width = 0.15)) + facet_wrap(~ perennial_trt, scales = "free_x", ncol = 4)


wheat_data %>% ggplot(aes(x = perennial_trt, y = ca)) + geom_boxplot() + facet_wrap(~ factor(year), scales = "free_x", ncol = 5) + labs(x = "", y = "Wheat Calcium Content") + theme_classic() + theme(plot.title = element_text(size = 14), legend.key.size = unit(1,"line"), axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 11, angle = 90, vjust = .5), axis.title.y = element_text(size = 15), axis.title.x = element_text(size = 16), legend.title = element_text(size = 16), legend.text = element_text(size = 14), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), strip.text.x = element_text(size = 14), strip.background = element_rect(color = "black", fill = "white", size = 1, linetype = "solid"), panel.border = element_rect(color = "black", fill = NA, linewidth = 1))

wheat_data %>% ggplot(aes(x = perennial_trt, y = protein)) + geom_boxplot() + facet_wrap(~ factor(year), scales = "free_x", ncol = 5) + labs(x = "", y = "Wheat Protein Content") + theme_classic() + theme(plot.title = element_text(size = 14), legend.key.size = unit(1,"line"), axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 11, angle = 90, vjust = .5), axis.title.y = element_text(size = 15), axis.title.x = element_text(size = 16), legend.title = element_text(size = 16), legend.text = element_text(size = 14), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), strip.text.x = element_text(size = 14), strip.background = element_rect(color = "black", fill = "white", size = 1, linetype = "solid"), panel.border = element_rect(color = "black", fill = NA, linewidth = 1))