#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Loading the data 
  
  ## download zip into R and then unzip the file
  zip.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dir <- getwd()
  zip.file <- "data.zip"
  zip.combine <- as.character(paste(dir, zip.file, sep = ";"))
  
  download.file(zip.url, destfile = zip.combine)
  
  unzip(zip.file)
  
  ## read in the "txt" data file
  df <- read.table("household_power_consumption.txt", sep = ";", na.strings ="?", header = TRUE)
  head(df)
  
  ##  Working with Date and Time
  
  df$date2 <- strptime(df$Date, "%d/%m/%Y")
  
  #subsetting data from the dates 2007-02-01 and 2007-02-02
  
  df_sub <- df[df$date2 >= "2007-02-01" & df$date2 <= "2007-02-02", ] #df_sub is the data.frame we will use
  
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    png("plot4.png", width = 480, height= 480)
  #set up the plot window
  par(mfrow = c(2, 2)) #fill by row first
  
  # Subplot 1 
  
  plot(df_sub$Global_active_power, type="l",xaxt="n", ylab = "Global Active Power", xlab = "")
  locations = floor(seq(from=0,to=nrow(df_sub),by=nrow(df_sub)/2))
  axis(side = 1, at = locations, labels=c("Thu", "Fri", "Sat"))
  
  # Subplot 2
  plot(df_sub$Voltage,type="l", ylab = "Voltage" , xaxt="n", xlab = "", sub = "datetime")
  locations = floor(seq(from=0,to=nrow(df_sub),by=nrow(df_sub)/2))
  axis(side = 1, at = locations, labels=c("Thu", "Fri", "Sat"))
  
  
  # Subplot 3
  plot(df_sub$Sub_metering_1,type="l",xaxt="n", ylab = "Energy sub metering", xlab = "")
  ## Add a second line
  lines(df_sub$Sub_metering_2,type="l",col = "red")
  ## Add a third line
  lines(df_sub$Sub_metering_3,type="l",col = "blue")
  ## Add a legend to the plot
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =1, col = c("black", "red", "blue"))
  
  locations = floor(seq(from=0,to=nrow(df_sub),by=nrow(df_sub)/2))
  axis(side = 1, at = locations, labels=c("Thu", "Fri", "Sat"))
  
  # Subplot 4
  
  with(df_sub,plot(Global_reactive_power, type="l",xaxt="n", ylab = "Global_reactive_power", xlab = "", sub = "datetime"))
  
  locations = floor(seq(from=0,to=nrow(df_sub),by=nrow(df_sub)/2))
  axis(side = 1, at = locations, labels=c("Thu", "Fri", "Sat"))
  
  # Save plot to file
  dev.copy(png,'plot4.png')
  dev.off()