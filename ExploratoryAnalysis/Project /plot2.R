## Task 2


# Loading RDS in to Memmory
rdData <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Sampling data for testing
rdData_sample <- rdData[sample(nrow(rdData), size = 5000, replace = F), ]

# Subsetting data and appending two years in one data frame
rdData_play <- subset(rdData, fips == '24510')

# Final results :)
png(filename = 'plot2.png', bg = "transparent")
barplot(tapply(X = rdData_play$Emissions, INDEX = rdData_play$year, FUN = sum), main = 'Total Emission in Baltimore City, rdData_play', xlab = 'Year', ylab = expression('PM'[2.5]))
dev.off()