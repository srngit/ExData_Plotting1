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
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))

df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

## Opens a png file
png(file="plot3.png") 

## creates a plot and send to a png file
plot3 <- function() {
plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$timestamp,df$Sub_metering_2,col="red")
lines(df$timestamp,df$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
}
plot3()










