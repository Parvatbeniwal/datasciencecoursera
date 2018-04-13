# Loading ggplot2 library
library(ggplot2)

# Loading RDS in to memmory
RData <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
RData$year <- factor(RData$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Baltimore City, Maryland dataset on road
maryLand_onRoad <- subset(RData, fips == '24510' & type == 'ON-ROAD')

# Los Angeles County, California dataset on road
california_onRoad <- subset(RData, fips == '06037' & type == 'ON-ROAD')

# Aggregation Baltimore City, Maryland
maryLand_by_year <- aggregate(maryLand_onRoad[, 'Emissions'], by = list(maryLand_onRoad$year), sum)
colnames(maryLand_by_year) <- c('year', 'Emissions')
maryLand_by_year$City <- paste(rep('MD', 4))

# Aggregation Los Angeles County, California
california_by_year <- aggregate(california_onRoad[, 'Emissions'], by = list(california_onRoad$year), sum)
colnames(california_by_year) <- c('year', 'Emissions')
california_by_year$City <- paste(rep('CA', 4))
DF <- as.data.frame(rbind(maryLand_by_year, california_by_year))

# Final results to be plotted
png(filename = "plot6.png",width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent")
gplot <- ggplot(data = DF, aes(x = year, y = Emissions)) +
     geom_bar(aes(fill = year),stat = "identity") + 
     guides(fill = F) + 
     ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
     ylab(expression('PM'[2.5])) + xlab('Year') + 
     theme(legend.position = 'none') + 
     facet_grid(. ~ City) + 
     geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))


print(gplot)
dev.off()