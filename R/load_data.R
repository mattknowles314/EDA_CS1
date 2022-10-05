# Load Data
GPG1718 <- read.csv(file = "data/GPG1718.csv")
GPG1819 <- read.csv(file = "data/GPG1819.csv")
GPG1920 <- read.csv(file = "data/GPG1920.csv")
GPG2021 <- read.csv(file = "data/GPG2021.csv")
GPG2122 <- read.csv(file = "data/GPG2122.csv")
unis <- read.csv("data/universities.csv")

# Add a year coolumn to each data
GPG1718$year <- 2017
GPG1819$year <- 2018
GPG1920$year <- 2019
GPG2021$year <- 2020
GPG2122$year <- 2021

# Compile data
GPG <- rbind(GPG1718, GPG1819, GPG1920, GPG2021, GPG2122)

# Remove NA data
GPG <- na.omit(GPG)
