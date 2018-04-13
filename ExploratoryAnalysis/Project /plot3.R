# loading ggplot2
library(ggplot2)

# Loading RDS in to Memmory
rdData <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/exp-data/summarySCC_PM25.rds")
SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/exp-data/Source_Classification_Code.rds")

# Baltimore City, Maryland == fips
subset <- rdData[rdData$fips == "24510", ] 
par("mar"=c(5.1, 4.5, 4.1, 2.1))

# final results :)
png(filename = "plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(subset, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
dev.off()