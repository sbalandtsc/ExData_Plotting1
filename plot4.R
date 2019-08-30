# this script constructs plot3.png

# read the Electric power consumption data, subsetting for the two dates of interest
powerdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")

# calculate datetime
library(lubridate)
date <- dmy(powerdata$Date)
time <- hms(powerdata$Time)
datetime <- paste(date, time)
powerdata <- cbind(datetime, powerdata)

# create plot4.png
png(file = "plot4.png")

# split the screen
par(mfcol = c(2,2))

# top left plot
plot(as.numeric(as.character(powerdata$Global_active_power)), type = "l", ylab = "Global Active Power", xaxt = 'n', xlab="")
axis(1, 0, "Thu")
axis(1, which(powerdata$datetime == "2007-02-02 0S"), weekdays(powerdata$Date[which(powerdata$datetime == "2007-02-02 0S")]))
axis(1, length(powerdata$Global_active_power), "Sat")

# bottom left plot
plot(as.numeric(as.character(powerdata$Sub_metering_1)), type = "l", ylab = "Energy sub metering", xaxt = 'n', xlab="")
lines(as.numeric(as.character(powerdata$Sub_metering_2)), col = "red")
lines(as.numeric(as.character(powerdata$Sub_metering_3)), col = "blue")
axis(1, 0, "Thu")
axis(1, which(powerdata$datetime == "2007-02-02 0S"), weekdays(powerdata$Date[which(powerdata$datetime == "2007-02-02 0S")]))
axis(1, length(powerdata$Global_active_power), "Sat")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n" )

# top right plot
with(powerdata, plot(Voltage, type = "l", xaxt = 'n', xlab="datetime"))
axis(1, 0, "Thu")
axis(1, which(powerdata$datetime == "2007-02-02 0S"), weekdays(powerdata$Date[which(powerdata$datetime == "2007-02-02 0S")]))
axis(1, length(powerdata$Global_active_power), "Sat")

# bottom right plot
with(powerdata, plot(Global_reactive_power, type = "l", xaxt = 'n', xlab="datetime"))
axis(1, 0, "Thu")
axis(1, which(powerdata$datetime == "2007-02-02 0S"), weekdays(powerdata$Date[which(powerdata$datetime == "2007-02-02 0S")]))
axis(1, length(powerdata$Global_active_power), "Sat")

dev.off()