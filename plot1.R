####################################### 
# Generate plot1 for Course Project 1 #
####################################### 

#
# Read in the ./data/household_power_consumption.txt file. 
#
readData <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    # Create data directory in the local directory if not yet there
    if (!file.exists("data")) {
        dir.create("data")
    }
    
    localName <- "data/household_power_consumption.txt"
    # Check if the file has already been downloaded
    if (!file.exists(localName)) {
        localZipName <- "data/household_power_consumption.zip"
        # Have we downloaded the zip file already
        if (!file.exists(localZipName)) {
            # Note: on Windows you may want to remove method = "curl"!
            # This code has been written on a Mac and not tested on Windows
            download.file(fileUrl, destfile = localZipName, method = "curl")
        }
        # Unzip the file
        unzip(localZipName, exdir = "./Data", overwrite = TRUE)
        
        # Write down meta data of the download
        library(tools)       # md5sum
        metaDataFile <- file.path("data", paste(basename(localName), 
                                                "-metadata.txt", sep = ""))
        sink(metaDataFile)
        print("Download date:")
        print(Sys.time() )
        print("Download URL:")
        print(fileUrl)
        print("Downloaded file Information")
        print(file.info(localZipName))
        print("Downloaded file md5 Checksum")
        print(md5sum(localZipName))
        sink()
    }
    # We first read 2 lines of the data to get the headers
    dt <- fread(localName, na.strings = "?", header = TRUE, 
                sep = ";", nrows = 2,
                colClasses = c("character", "character", rep("numeric", 7)))
    headers <- names(dt)
    
    # Now read the data table starting from the 1/2/2007 entry
    dt <- fread(localName, na.strings = "?", header = FALSE,
                sep = ";", skip = "1/2/2007", 
                nrows = 2 * 24 * 60, # 2 days of minute by minute data
                colClasses = c("character", "character", rep("numeric", 7)))
    
    # The data table read with fread above is without headers, so we will
    # set them now. Now that we cannot use 
    # names(dt) <- headers; if you do you get a warning: 
    # The names(x)<-value syntax copies the whole table. This is due to <- 
    # in R itself. Please change to setnames(x,old,new) which does not 
    # copy and is faster.
    setnames(dt, headers)
    
    # Use the lubridate package for date and time management
    library(lubridate)
    
    # Format the time column. We concatenate the Date and Time field 
    # separated by a " " and then transform it to a time using dmy_hms in 
    # the lubridate package (strptime could not do it in one single statement).
    dt[, Time := dmy_hms(paste(Date, Time, sep = " "))]
    
    # Format the date column
    dt[, Date := as.Date(Date, "%d/%m/%Y")]
    
    # Return the data table
    dt
}

#
# Create plot 1
#
plot1 <- function() {
    #
    # Read the data from the file; download if necessary
    #
    dt <- readData()
     
    #
    # Plot the data
    #
    
    # Open a PNG device
    pngDevice <- png(filename = "figure/plot1.png",
                     bg = "transparent",
                     width = 480, height = 480) # these are also the default
    
    # Create the plot
    hist(dt$Global_active_power,                     # data series
         col = "red",                                # colour
         xlab = "Global Active Power (kilowatts)",   # x-axis label
         main = "Global Active Power")               # title
    
    # Close the device and hence save the file
    dev.off()
}
