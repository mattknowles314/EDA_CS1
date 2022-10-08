library(dplyr)
library(tidyr)
library(rgdal)
library(sp)
library(leaflet)

# Which unis reported for all years
uniGPG <- GPG %>%
    filter(EmployerName %in% unis$EmployerName)

# Get the count of reporting
uni_year_count <- uniGPG %>%
    count(EmployerName)

# Plot the density of reporting frequency
uni_year_count_density <- density(uni_year_count$n)
plot(uni_year_count_density)

# MedianHourlyPercent

getDens <- function(data, year){
    X <- data %>%
        filter(year == year)
    Y <- density(X$DiffMedianHourlyPercent)
    return(Y)
}

bonus_diff_dens_2017 <- getDens(uniGPG, year = 2017)
bonus_diff_dens_2018 <- getDens(uniGPG, year = 2018)
bonus_diff_dens_2019 <- getDens(uniGPG, year = 2019)
bonus_diff_dens_2020 <- getDens(uniGPG, year = 2020)
bonus_diff_dens_2021 <- getDens(uniGPG, year = 2021)
bonus_diff_dens_2022 <- getDens(uniGPG, year = 2022)

# Stacked density plots

ggplot(uniGPG, aes(x = DiffMeanHourlyPercent, fill = year)) +
    geom_density(position = "stack")

# How does size relate to differences

X <- as.matrix(select(uniGPG, DiffMeanHourlyPercent, DiffMeanBonusPercent, EmployerSize))

ggplot(uniGPG, aes(x = DiffMeanHourlyPercent, y = DiffMeanBonusPercent)) +
    geom_point() +
    stat_smooth(method = "lm", col = "magenta") +
    ylim(-150,200)

# Some more testing

A <- uniGPG %>%
    group_by(EmployerName) %>%
    summarise(avg_hourDiff = mean(DiffMeanHourlyPercent),
              avf_bonusDiff = mean(DiffMeanBonusPercent))

# Postcodes
X <- uniGPG %>%
    group_by(EmployerName) %>%
    summarise(Town = str_replace(PostCode, "(?s) .*", ""))
Y <- unique(X)

names(postcodes) <- c("id", "Town", "latitude", "longitude")
Z <- merge(Y, postcodes, by = "Town")

leaflet() %>%
    setView(lng = -1.47, lat = 55, zoom = 5) %>%
    addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
    addCircles(lat = Z$latitude,
               lng = Z$longitude)
