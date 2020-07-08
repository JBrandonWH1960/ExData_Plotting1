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
## Create Graph Number 1: Histogram
hist(graphData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## save the histogram graph file then close the device
dev.copy(png, "c:/users/jbwhe/documents/GIT repositories/ExData_Plotting1/plot1.png", width = 480, height=480)
dev.off()