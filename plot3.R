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

#Sets the device and output
png("plot3.png", width=480, height=480)

#Creates a plot with three lines from separate data
plot(data_feb$datetime, data_feb$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_feb$datetime, data_feb$Sub_metering_2, type = "l", col = "red")
lines(data_feb$datetime, data_feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1))

dev.off()