source("DataReader.R")

#get prepared data
data <- read_data("../../data/household_power_consumption.txt")
#View(data)

#draw the plot
par (bg = "transparent") #use transparent background
hist (data$Global_active_power, col = 'red', 
      xlab = 'Global Active Power (kilowatts)',
      main = 'Global Active Power')
dev.copy(png, "plot1.png") #makes 480x480 PNG file
dev.off() #close PNG device