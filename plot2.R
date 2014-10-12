install.packages("sqldf")
library(sqldf)

hpc<-file("household_power_consumption.txt")
attr(hpc, "file.format") <- list(sep = ";", header = TRUE)
hpc.data<-sqldf("select * from hpc where Date = '1/2/2007' or Date = '2/2/2007'")
hpc.data$DateTime <- strptime(paste(hpc.data$Date, hpc.data$Time), "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
plot(hpc.data$DateTime, hpc.data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", main = "")
dev.off()