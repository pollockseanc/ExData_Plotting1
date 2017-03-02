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

#Sets device and output
png("plot1.png", width=480, height=480)

#Create plot
with(data_feb, hist(Global_active_power, main = "Global Active Power", xlab ="Global Active Power (kilowatts", col="red"))

dev.off()