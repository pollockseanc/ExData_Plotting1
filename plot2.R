#Required libraries

if (!require(dplyr)) {
        stop("You are missing the package dplyr Please install it before continuing.")
} else if (!require(data.table)) {
        stop("You are missing the package data.table. Please install it before continuing.")
}

library(dplyr)
library(data.table)

#Imports the data and extracts only the relevant dates
data<- fread("household_power_consumption.txt", header=T, sep = ";", na.strings="?")
data_feb <- as.data.frame(data[data$Date == "1/2/2007" | data$Date=="2/2/2007",])

#Removes the old data that is now no longer needed
rm(data)

#Adds a new column to the table that allows you to easily use the date and time 
data_feb <- mutate(data_feb, datetime = paste(Date, Time, sep="-"))
data_feb$datetime <- as.POSIXct(data_feb$datetime, "%d/%m/%Y-%H:%M:%S", tz = "GMT")

#Sets the device
png("plot2.png", width=480, height=480)

#Creates a plot
plot(data_feb$datetime, data_feb$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts")

dev.off()