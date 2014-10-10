source("DataReader.R")

#get prepared data
data <- read_data("../../data/household_power_consumption.txt")
#View(data)

#draw the plot
#have to change locle to get nice weekdays labels "Thu", "Fri" and "Sat"
my_loc <- Sys.getlocale (category = "LC_TIME")
Sys.setlocale  (category = "LC_TIME", locale = "C")

plot3 <- function () {
  #par (bg = "transparent") #use transparent background
  plot (data$Sub_metering_1 ~ data$DateTime, type = 'n',
        ylab = 'Energy sub metereng', xlab = "")
  lines (data$Sub_metering_1 ~ data$DateTime, )
  lines (data$Sub_metering_2 ~ data$DateTime, col = "red")
  lines (data$Sub_metering_3 ~ data$DateTime, col = "blue")
  legend("topright",  col = c("black","red", "blue"), legend = colnames(data[0,7:9]),
         lty = 'solid')
}
#plot in windows()
#plot3()
#plot in png()
png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
plot3()
dev.off() #close PNG device
Sys.setlocale  (category = "LC_TIME", locale = my_loc) #restore locale
