##
## Jesse (Brandon) Wheeler
##
## Set Working Directoy to Data
setwd("C:/users/jbwhe/documents/training/data")

## As a time saving effort I grabbed the zip file, extracted necessary data
## into my data directory.  I could have written code to automatically extract.
##
## Load the power consumption data into my graphData 
graphData <- read.table("household_power_consumption.txt", 
                        header = TRUE, sep=";", na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

##
## Formate the Date field as Date
graphData$Date <- as.Date(graphData$Date, "%d/%m/%Y")

##
## subset the data set "graphData" to 2007 (0201-0202)
graphData <- subset(graphData,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

##
## Clean up the data set by removing any bad observations
graphData <- graphData[complete.cases(graphData),]

##
## Create new dateTime variable combining the date and time
dateTime <- paste(graphData$Date, graphData$Time)

##
## set column name to be DateTime
dateTime <- setNames(dateTime, "DateTime")

##
## Remove the existing date and time variables
graphData <- graphData[,!(names(graphData) %in% c("Date","Time"))]

##
## add the new combined date and time variable to graphData
graphData <- cbind(dateTime, graphData)

##
## format new date/time variable
graphData$dateTime <- as.POSIXct(dateTime)
##
##
##
## Create Graph Number 4: Combined Plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(graphData, {
        plot(Global_active_power~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~dateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col="red")
        lines(Sub_metering_3~dateTime,col="blue")
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime, type="l", 
             ylab="Global Reactive Power (kilowatts)",xlab="")
})

dev.copy(png, "c:/users/jbwhe/documents/GIT repositories/ExData_Plotting1/plot4.png", width = 480, height=480)
dev.off()