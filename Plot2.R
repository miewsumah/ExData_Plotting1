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

# plot 2
datetime <- strptime(paste(subsetpower$Date, subsetpower$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

attach(subsetpower)

plot(datetime,Global_active_power, type = "l",
     
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png", height = 480, width = 480)

dev.off()

detach(subsetpower)

