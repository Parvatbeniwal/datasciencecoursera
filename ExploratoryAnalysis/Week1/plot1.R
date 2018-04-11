# Loading  dataset
hpcData <- read.csv("/Users/psingh/Downloads/household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## Subsetting the data and Converting dates
subHpcData <- subset(hpcData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##Removing Object it Hold 133Mb data
rm(hpcData)
pas_hpcData <- paste(as.Date(subHpcData$Date), subHpcData$Time)
subHpcData$Datetime <- as.POSIXct(pas_hpcData)

## Plot 1 geneerated
hist(subHpcData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file and closing graphic Device
dev.copy(png, file="/Users/psingh/datasciencecoursera/datasciencecoursera/ExploratoryAnalysis/Week1/plot1.png", height=480, width=480)
dev.off()