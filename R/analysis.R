library(dplyr)
library(tidyr)

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

