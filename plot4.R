# Based on inspection, data for 2007-02-01 starts after line 66637, and data
# for 2007-02-02 ends at 2879 rows.  Setting skip and nrow to keep from bringing
# in the entire dataset - my poor computer is low on memory.
pwrCnsmp <- read.csv('household_power_consumption.txt', 
                     skip = 66637, nrow = 2879, header = F, sep = ";")
colnames(pwrCnsmp) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Create a new column called dateTime with the correct class to replace the "Date" and "Time"
# character columns
pwrCnsmp$dateTime <- strptime(paste(pwrCnsmp$Date, pwrCnsmp$Time), format = "%d/%m/%Y %H:%M:%S")

# Open a PNG device and create the plot(s)
png(filename = "plot4.png")
par(mfrow = c(2,2))

# Plot 4a
plot(pwrCnsmp$dateTime, pwrCnsmp$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# Plot 4b
plot(pwrCnsmp$dateTime, pwrCnsmp$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot 4c
plot(pwrCnsmp$dateTime, pwrCnsmp$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(pwrCnsmp$dateTime, pwrCnsmp$Sub_metering_2, type = "l", col = "red")
lines(pwrCnsmp$dateTime, pwrCnsmp$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Plot 4d
plot(pwrCnsmp$dateTime, pwrCnsmp$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()