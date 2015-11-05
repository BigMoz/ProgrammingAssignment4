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

#plot graph1
png(filename="plot1.png")
hist(slct$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

