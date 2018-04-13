# Loading ggplot2 package
library(ggplot2)

# Loading data in memmory
RDATA <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
RDATA$year <- factor(RDATA$year, levels = c('1999', '2002', '2005', '2008'))

SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Baltimore City, Maryland == fips , On road data
onRoad <- subset(RDATA, fips == 24510 & type == 'ON-ROAD')

# Aggregation
eboyear <- aggregate(onRoad[, 'Emissions'], by = list(onRoad$year), sum)
colnames(eboyear) <- c('year', 'Emissions')

# Final results to be stored in plot5.png
png(filename = "plot5.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")



gplot <- ggplot(data = eboyear, aes(x = year, y = Emissions)) + 
     geom_bar(aes(fill = year), stat = "identity") +
     guides(fill = F) + 
     ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') +
     ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + 
     geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))

print(gplot)
dev.off()