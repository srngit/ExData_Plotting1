library(data.table)
## read data from the downloaded text file 
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings=c("?"),stringsAsFactors=FALSE)

## create a subset containing only the relevant (2007February 1,2) data
feb1data <- data[data$Date=="1/2/2007", ]
feb2data <- data[data$Date=="2/2/2007", ]
febdata <- rbind(feb1data,feb2data)

## Opens a png file
png(file="plot1.png") 

## creates a hostogram and send to a png file
hist(febdata$Global_active_power, 
     col ="red",
     main ="Global Active Power",
xlab ="Global Active Power(kilolowatts)",
ylab ="Frequency")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()