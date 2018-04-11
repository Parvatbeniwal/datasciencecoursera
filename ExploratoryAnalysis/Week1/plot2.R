# Loading  dataset
hpcData <- read.csv("/Users/psingh/Downloads/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## Subsetting the data and Converting dates
subHpcData <- subset(hpcData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##Removing Object it Hold 133Mb data
rm(hpcData)
pasHpcData <- paste(as.Date(subHpcData$Date), subHpcData$Time)
subHpcData$Datetime <- as.POSIXct(pasHpcData)

## Plot 2 generated
## Saving to file and closing graphic Device
plot(subHpcData$Global_active_power~subHpcData$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="/Users/psingh/datasciencecoursera/datasciencecoursera/ExploratoryAnalysis/Week1/plot2.png", height=480, width=480)
dev.off()