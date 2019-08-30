# this script constructs plot2.png

# read the Electric power consumption data, subsetting for the two dates of interest
powerdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")

# calculate datetime
library(lubridate)
date <- dmy(powerdata$Date)
time <- hms(powerdata$Time)
datetime <- paste(date, time)
powerdata <- cbind(datetime, powerdata)

# create plot2.png
png(file = "plot2.png")
plot(as.numeric(as.character(powerdata$Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)", xaxt = 'n', xlab="")
axis(1, 0, "Thu")
axis(1, which(powerdata$datetime == "2007-02-02 0S"), weekdays(powerdata$Date[which(powerdata$datetime == "2007-02-02 0S")]))
axis(1, length(powerdata$Global_active_power), "Sat")
dev.off()