#Programming Assignment 1
setwd("C:/Users/Matthias/Dropbox/PhD/R/Exploratory data analysis")

#load library
library(dplyr)

#load data
data <- read.table("C:/Users/Matthias/Desktop/household_power_consumption.txt", sep = ";", header=TRUE, row.names = NULL, na.strings = c("?"))
data <- tbl_df(data)

#convert date and time format
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- format(data$Time, format = "%H:%M:%S", tz = "GMT")

#subset data
slct <- data[grep("2007-02-01|2007-02-02", data$Date),]
slct <- mutate(slct, combdate = with(slct, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")))
rm(data)

#plot graph4
png(filename="plot4.png")
par(mfrow=c(2,2))
plot(slct$combdate, slct$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
plot(slct$combdate, slct$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
plot(slct$combdate, slct$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(slct$combdate, slct$Sub_metering_2, type="l", col="red")
lines(slct$combdate, slct$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black","blue","red"), bty = "n")
plot(slct$combdate, slct$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

