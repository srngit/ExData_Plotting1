library(data.table)
## read data from the downloaded text file 
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings=c("?"),stringsAsFactors=FALSE)

## create a subset containing only the relevant (2007February 1,2) data
feb1data <- data[data$Date=="1/2/2007", ]
feb2data <- data[data$Date=="2/2/2007", ]
febdata <- rbind(feb1data,feb2data)

febdata$Date <- as.Date(febdata$Date, format="%d/%m/%Y")
df <- febdata[(febdata$Date=="2007-02-01") | (febdata$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Opens a png file
png(file="plot2.png") 

## creates a plot and sends to a png file

plot1 <- function() 
{
plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
}

plot1()
