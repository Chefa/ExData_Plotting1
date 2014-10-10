#install.packages("sqldf")


#read data
read_data <- function(file) {
  #file <- "../../data/household_power_consumption.txt"
  # #using data from the dates 2007-02-01 and 2007-02-02.
  # library (sqldf)
  # sql_filter <- "SELECT * FROM file WHERE (Date = '1/2/2007' OR Date = '2/2/2007')"
  # system.time(full_data <- read.csv.sql(file = file, header = TRUE, sep = ";",
  #                                       sql = sql_filter,
  #                                       dbname = NULL)) #too slow ~12 sec
  library(data.table) #for fread()
  col_cls <- sapply(fread(file, nrow=10),class)
  col_cls <- rep("character", times = length(col_cls)) #to supress warnings and coercing in fread()
  system.time(full_data <- fread (input = "../../data/household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      na.strings = c("?"),
                      colClasses = col_cls,
                      data.table = FALSE))
  #class(full_data) # "data.frame"
  #head(full_data)
  #sapply(full_data,class)
  #object.size(full_data)/2^20 #~143Mb
  
  #filter data
  #using data from the dates 2007-02-01 and 2007-02-02.
  library(dplyr)
  work_data <- filter (full_data, Date == '1/2/2007' | Date == '2/2/2007')
  rm (full_data)
  #coerce to right data types
  #work_data <- mutate(work_data, new_date = as.Date(Date,format = "%d/%m/%Y" ) ) #%e
  work_data$DateTime <- as.POSIXct (paste (work_data$Date, work_data$Time), format = "%d/%m/%Y %H:%M:%S")
  work_data$Date <- as.Date(work_data$Date,format = "%d/%m/%Y")
  work_data$Time <-  strptime(work_data$Time, format = "%H:%M:%S") #- Sys.Date()
  work_data[,3:9] <- sapply(work_data[,3:9], as.numeric) 
  #View (work_data)
  #sapply(work_data,class)
  return (work_data)
} #read_data
