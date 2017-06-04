CodeBook- Instructions for creating plots 1, 2, 3, & 4
#####################################################

Important: set your working directory before running the code in lines 5 and 9 of the code:
  
  # Set working directory
  #====== >setwd("yourWORKINGDIRCTORYhere")
  
  # Set the same working file path before the \\Assignment1" script
  #====== >filepath <- "yourWORKINGDIRCTORYhere\\Assignment1"
  
  The first section of code in files plot1.R, plot2.R, plot3.R, & plot4.R), down to the hash "########################" line,
near the bottom of the code block, is exactly the same for all four plots. The create and save plot code below the hash line 
differs for each of plot1.R, plot2.R, plot3.R, & plot4.R

After setting the working directory as indicated above the lubridate and dplyr librariers are loaded.

Next the script creates a work folder to extract and write the data to. The raw data file are then downloaded, unzipped and 
read to "epc_data", acknowledging the presence of a header row, semi-colon as column separator, and changing the missing values 
character "?" to "NA"

In the next step any missing data sets are removed and the column names changed to lower case.

This step is followed by changing the "factor" or "charater" date format to a date format. The "date format" is then read back 
into a data frame format, and the column given a name "date". The "date format" data frame is then reunited with the data from 
the original data frame.

Next a subset of data for the two day period needed for the plots are created in "epc_subset". With the smaller data set the "factor" 
or "charater" "time" format is reformatted incorporating the "date" to a "POSIXct" timestamp format and read into a data frame 
"epc_subset2". The column  name is adjusted to "date_time" and the date-time-stamp reunited with the rest of the data and read 
into "epc_eval_data".

CodeBook- Variables 
###################
# Raw data file place holder
epc_data

# Data set with removed missing values and column names set to lower case
epc_data2

# Data set with date format changed from "factor" or "charater"
epc_data3

# Date data set recombined with original data set
epc_data4

# Subset of data for the two day period (beging Feb 1 to end Feb 2, 2007) under investigation
epc_subset

# Subset of data with date and time changed to "POSIXct" timestamp format and column renamed to "date_time"
epc_subset2

# Final data set for evaluation with "POSIXct" timestamp reunited with original data set
epc_eval_data

CodeBook- General Code Function
###############################

After setting the working directory and executing the script, the code will:
  1. check for and create a working folder.
2. download the raw data file from the url supplied.
3. unzip the raw data file in the working environment chose.
4. Read raw text file into "epc_data"  accounting for column headers, column separators ";", and missing "?" vales to "NA"
5. Missing values is then removed and read into "epc_data2
6. Column names are then all set to lower case
7. Change the "factor" or "charater" date format to a date format.
8. Read the corrected dates back into a data frame as "epc_data3", and name the column "date"
10. Reunite the correct date format in "epc_data4" with the original data frame, substituting the "factor" or "charater" date 
format for a true date format.
11. Create subset of data for the date period under study and read into "epc_subset"
12. With the smaller subset change time & date to "POSIXct" timestamp format and read values into a data frame "epc_subset2"
13. Add column name as "date_time"
14. Reunit the "POSIXct" timestamp data set with the original data in "epc_eval_data"
15. Create and save the 480 x 480 pixel plots to working directory usign png and plot commands 
16. Close the graphics device

CodeBook -  Plots Code
######################
Plot 1: # Create Histogram with "global_active_power"
hist(epc_eval_data$global_active_power, col ="red", main="Global Active Power",xlab = "Global Active Power (kilowatts)", ylab = "Frequency" )

Plot 2: # Create plot for "global_active_power" as function of "date_time"
with(epc_eval_data, plot(global_active_power~date_time, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

Plot 3:	# Create plot for "sub_metering_1 & 2 & 3" as a function of "date_time"
with(epc_eval_data, plot(voltage~date_time, type="l", col="black", ylab="Voltage", xlab="datetime"))
with(epc_eval_data, plot(sub_metering_1~date_time, type="l", col="black", ylab="Energy sub metering", xlab=""))
with(epc_eval_data, points(date_time,sub_metering_2, type="l", col="red"))
with(epc_eval_data, points(date_time,sub_metering_3, type="l", col="blue"))
with(epc_eval_data,legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))

Plot 4:	# Create four plot layout
par(mfrow = c(2,2))

# Create plot for "global_active_power" as function of "date_time"
with(epc_eval_data, plot(global_active_power~date_time, type="l", ylab="Global Active Power", xlab=""))

# Create plot for "voltage" as function of "date_time"
with(epc_eval_data, plot(voltage~date_time, type="l", col="black", ylab="Voltage", xlab="datetime"))