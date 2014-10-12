install.packages("sqldf")
library(sqldf)

hpc<-file("household_power_consumption.txt")
attr(hpc, "file.format") <- list(sep = ";", header = TRUE)
hpc.data<-sqldf("select * from hpc where Date = '1/2/2007' or Date = '2/2/2007'")
hpc.data$DateTime <- strptime(paste(hpc.data$Date, hpc.data$Time), "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(hpc.data$DateTime, hpc.data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", main = "")

plot(hpc.data$DateTime, hpc.data$Voltage, type="l", ylab="Voltage", xlab="datetime", main = "")

plot(hpc.data$DateTime, hpc.data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", main = "")
lines(hpc.data$DateTime, hpc.data$Sub_metering_2, col="red")
lines(hpc.data$DateTime, hpc.data$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

plot(hpc.data$DateTime, hpc.data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", main = "")


dev.off()