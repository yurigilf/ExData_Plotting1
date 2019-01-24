#load libraries

library(dplyr)
setwd()
#read the txt file and convert into a table
table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#convert date to a better format, create POSIxct column
table <- table %>% mutate(DateTime = as.POSIXct(paste(Date,Time),format = "%d/%m/%Y %H:%M:%OS"))
table <- table %>% mutate(Date = as.Date(Date,format = "%d/%m/%Y"))

#convert factors to numeric
table <- table %>% mutate(Global_active_power = as.character(Global_active_power),Global_reactive_power = as.character(Global_reactive_power), Voltage = as.character(Voltage))
table <- table %>% mutate(Global_intensity = as.character(Global_intensity),Sub_metering_1 = as.character(Sub_metering_1),Sub_metering_2 = as.character(Sub_metering_2), Sub_metering_3 = as.character(Sub_metering_3))

table <- table %>% mutate(Global_active_power = as.numeric(Global_active_power),Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage))
table <- table %>% mutate(Global_intensity = as.numeric(Global_intensity),Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))

#get only neeeded dates
t1 <- filter(table, Date == "2007-02-01")
t2 <- filter(table, Date == "2007-02-02")
tb <- rbind(t1,t2)

#create 4 graphs on the same plot 
par(mfrow=c(2,2))

plot(tb$Global_active_power ~ tb$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")

plot(tb$Voltage ~ tb$DateTime, type = "l", ylab = "Voltage", xlab ="")

plot(tb$Sub_metering_1 ~ tb$DateTime, type = "l", ylab = "Energy sub metering", xlab ="")
lines(tb$DateTime,tb$Sub_metering_2, col = "red")
lines(tb$DateTime,tb$Sub_metering_3, col = "blue")
legend ("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = "----")

plot(tb$Global_reactive_power ~ tb$DateTime, type = "l", ylab = "Global Reactive Power", xlab ="")


#create the pgn file
png(filename = "plot4.png")
par(mfrow=c(2,2))

plot(tb$Global_active_power ~ tb$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")

plot(tb$Voltage ~ tb$DateTime, type = "l", ylab = "Voltage", xlab ="")

plot(tb$Sub_metering_1 ~ tb$DateTime, type = "l", ylab = "Energy sub metering", xlab ="")
lines(tb$DateTime,tb$Sub_metering_2, col = "red")
lines(tb$DateTime,tb$Sub_metering_3, col = "blue")
legend ("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = "----")

plot(tb$Global_reactive_power ~ tb$DateTime, type = "l", ylab = "Global Reactive Power", xlab ="")
dev.off()



