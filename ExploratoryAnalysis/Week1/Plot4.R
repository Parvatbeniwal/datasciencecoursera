# Loading  dataset
hpcData <- read.csv("/Users/psingh/Downloads/household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## Subsetting the data
subHpcData <- subset(hpcData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##Removing Object it Hold 133Mb data
rm(hpcData)

## Converting dates
pashpcData <- paste(as.Date(subHpcData$Date), subHpcData$Time)
subHpcData$Datetime <- as.POSIXct(pashpcData)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subHpcData, {
     plot(Global_active_power~Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
     plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
     plot(Sub_metering_1~Datetime, type="l",  ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~Datetime,col='Red')
     lines(Sub_metering_3~Datetime,col='Blue')
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~Datetime, type="l",  ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="/Users/psingh/datasciencecoursera/datasciencecoursera/ExploratoryAnalysis/Week1/plot4.png", height=480, width=480)
dev.off()