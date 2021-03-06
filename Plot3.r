# download the file into own folder.
filename <- "household_power_consumption.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# unzip the file after download  
if (!file.exists("household_power_consumption"))  
  unzip(filename) 

# subset the data
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
subsetpower <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]

head(subsetpower,10)

# plot 3
datetime <- strptime(paste(subsetpower$Date, subsetpower$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

attach(subsetpower)

plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(datetime, Sub_metering_2, col = "Red")
lines(datetime, Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
detach(subsetpower)

