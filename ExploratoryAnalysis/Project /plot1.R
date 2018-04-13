##Task 1


# Loading RDS in to Memory
rdData <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Sampling data for testing
rdData_sample <- rdData[sample(nrow(rdData), size = 1000, replace = F), ]

# Aggregation of Emmision by year in 4 groups 1999, 2002, 2005 and 2008
Emissions <- aggregate(rdData[, 'Emissions'], by = list(rdData$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

# Results : Plot Emission by year)
png(filename = "plot1.png", bg = "transparent")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()