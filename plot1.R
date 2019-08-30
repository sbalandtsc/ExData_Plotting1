# this script constructs plot1.png

# read the Electric power consumption data, subsetting for the two dates of interest
powerdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")

# create plot1.png
png(file = "plot1.png")
hist(powerdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()