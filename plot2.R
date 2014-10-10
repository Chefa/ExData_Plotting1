source("DataReader.R")

#get prepared data
data <- read_data("../../data/household_power_consumption.txt")
#View(data)

#draw the plot
#have to change locle to get nice weekdays labels "Thu", "Fri" and "Sat"
my_loc <- Sys.getlocale (category = "LC_TIME")
Sys.setlocale  (category = "LC_TIME", locale = "C")
par (bg = "transparent") #use transparent background
plot (data$Global_active_power ~ data$DateTime, type = 'l',
      ylab = 'Global Active Power (kilowatts)',
      xlab = "")
dev.copy(png, "plot2.png") #makes 480x480 PNG file
dev.off() #close PNG device
Sys.setlocale  (category = "LC_TIME", locale = my_loc) #restore locale