library(ggplot2)

# Loading RDS in to Memmory
rdData <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/Users/psingh/Downloads/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Coal-related SCC with case insensitive
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merging two data sets by SCC and aggregating later by year
merge <- merge(x = rdData, y = SCC.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

png(filename = "plot4.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")

#Plotting final Result in png device
gplot <- ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000))
gplot <- gplot + geom_line(aes(group = 1, col = Emissions)) +
     geom_point(aes(size = 2, col = Emissions)) + 
     ggtitle(expression('Total Emissions of PM'[2.5])) + 
     ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
     geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
     theme(legend.position = 'none') + scale_colour_gradient(low = 'black', high = 'red')

print(gplot)
dev.off()