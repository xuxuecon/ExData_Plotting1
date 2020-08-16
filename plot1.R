+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Plot
png("plot1.png", width = 480, height= 480)
hist(df_sub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", yaxt="n") # yaxt = "n" to "Turn off y-axis"
# customized y-axis
axis(2, seq(0,1200, 200 ))

# save plot to file

dev.off()