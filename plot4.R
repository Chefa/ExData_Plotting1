source("DataReader.R")

#get prepared data
data <- read_data("../../data/household_power_consumption.txt")

#draw the plot
plot4 <- function () {
  par (mfrow = c(2,2)) 
  
  with (data, {
    #topleft plot
    plot (Global_active_power ~ DateTime, type = 'l', xlab = "", ylab = 'Global Active Power')
    
    #topright plot
    plot (Voltage ~ DateTime, type = 'l', xlab = 'datetime', ylab = 'Voltage')
    
    #bottomleft plot
    plot (data$Sub_metering_1 ~ data$DateTime, type = 'n',
          ylab = 'Energy sub metereng', xlab = "")
    lines (data$Sub_metering_1 ~ data$DateTime, )
    lines (data$Sub_metering_2 ~ data$DateTime, col = "red")
    lines (data$Sub_metering_3 ~ data$DateTime, col = "blue")
    legend("topright",  col = c("black", "red", "blue"), legend = colnames(data[0,7:9]), lty = 'solid',
           bty = "n")
    
    #bottomright plot
    plot (Global_reactive_power ~ DateTime, type = 'l', xlab = "datetime", lwd = 0.8)
  })
}

#have to change locle to get nice weekdays labels "Thu", "Fri" and "Sat"
my_loc <- Sys.getlocale (category = "LC_TIME")
Sys.setlocale  (category = "LC_TIME", locale = "C")
#plot in windows()
#plot4()

#plot in png()
#need to use type="cairo" to get thin lines in bottomright plot
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent", type = "cairo")
plot4()
dev.off() #close PNG device
Sys.setlocale  (category = "LC_TIME", locale = my_loc) #restore locale