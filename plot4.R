#plot4.R
#Run this script from the set working directory containing the household_power_consumption.txt file downloaded
#and unzipped from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Load necessary libraries
library(dplyr)
library(lubridate)
#Load and filter data
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data.f <- filter(data, as.Date(dmy(Date)) == "2007-02-01" | as.Date(dmy(Date)) == "2007-02-02")
rm(data)
# Need to combine Date & Time and convert to Date
datetime <- as.POSIXct(strptime(paste(dmy(data.f$Date), data.f$Time), "%Y-%m-%d %H:%M:%S"))
#Create and save plot
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), oma = c(0,2,0,0))
with(data.f, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
with(data.f, plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(data.f, {
    plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(datetime, Sub_metering_2, type = "l", col = "red")
    lines(datetime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lwd = 2, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", xjust = 0)
})
with(data.f, plot(datetime, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()