library(dplyr)
library(tidyr)

# Which unis reported for all years

# Get the count of reporting
uni_year_count <- GPG %>%
    filter(EmployerName %in% unis$EmployerName) %>%
    count(EmployerName)

# Plot the density of reporting frequency
uni_year_count_density <- density(uni_year_count$n)
plot(uni_year_count_density)
