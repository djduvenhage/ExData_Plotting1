##### Exploratory Data Analysis Week 1 Assignment 1 plot3 ######

# Important:
#            Set a working directory and file path where you want to work and manipulate the data 
setwd("yourWORKINGDIRCTORYhere")

# Important:
#            Set correct file path below, before the "\\Assignment1"
filepath <- "yourWORKINGDIRCTORYhere\\Assignment1"

# Load Libraries to use.
library(lubridate)
library(dplyr)

# Create work folder to extract and write data to
if(!file.exists("./Assignment1")){dir.create("./Assignment1 ")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download raw data files
download.file(fileUrl,destfile="./Assignment1/Dataset.zip")

# Unzip raw dataSet to /Data directory
unzip(zipfile="./Assignment1/Dataset.zip",exdir="./Assignment1")

# Read the raw data text files,acknowledging the presence of a header row, semi-colon as column separator, and changing the missing values character "?" to "NA"
epc_data <- read.table(file.path(filepath,"household_power_consumption.txt "), header = TRUE, sep =";" , na.strings = c("?", "NA"))

# Remove any missing data sets
epc_data2 <- na.omit(epc_data)

# Change column names to lower case
names(epc_data2) <- tolower(names(epc_data2))

# Change the "factor" or "charater" date format to a date format, read the dates back into a data frame, and name the column
epc_data3 <- as.Date(as.character(epc_data2$date), format = "%d/%m/%Y")
epc_data3 <- data.frame(epc_data3)
colnames(epc_data3) <- "date"

# Reunite the correct date format with the original data frame, substituting the "factor" or "charater"date form at for a true date format
epc_data4 <- cbind(epc_data3, epc_data2[,2:9])

# Create subset of data for the date period needed
date1 <- ymd ("2007-01-31")
date2 <- ymd("2007-02-03")
epc_subset <- subset(epc_data4, date >date1 & date < date2)

# With the smaller subset change time & date to "POSIXct" timestamp format (did not do this on large data set as it is memory intensive)
epc_subset2 <- as.POSIXct(paste(epc_subset$date, epc_subset$time))
epc_subset2 <- data.frame(epc_subset2)
colnames(epc_subset2) <- c("date_time")

# Reunit the date-time-stamp with rest of the data
epc_eval_data <- cbind(epc_subset2, epc_subset[,3:9])

### Code above applies to plot 1, 2, 3, and 4
##################################################################################################################################################################

# Create and Save Line Plot for "voltage" as a function of "date_time" to active working directory 
png(file.path(filepath,filename="plot3.png"), width=480, height=480)

with(epc_eval_data, plot(voltage~date_time, type="l", col="black", ylab="Voltage", xlab="datetime"))
with(epc_eval_data, plot(sub_metering_1~date_time, type="l", col="black", ylab="Energy sub metering", xlab=""))
with(epc_eval_data, points(date_time,sub_metering_2, type="l", col="red"))
with(epc_eval_data, points(date_time,sub_metering_3, type="l", col="blue"))
with(epc_eval_data,legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))

dev.off()
