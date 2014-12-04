# Generate plot2 for Course Project 1

# We won't rewrite the file loading part but just source it in from plot1.R
source("plot1.R")

plot2 <- function() {
    #
    # Read the data from the file; download if necessary. The function 
    # readData() is defined in plot1.R and sourced in (see above). 
    #
    dt <- readData()
    
    #
    # Plot the data
    #
    
    # Open a PNG device
    pngDevice <- png(filename = "figure/plot2.png",
                     bg = "transparent",
                     width = 480, height = 480) # these are also the default
    
    # Create the plot
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Global_active_power,           # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  ylab = "Global Active Power (kilowatts)",  # only y label
                  xlab = "",                         # no x label
                  main = ""))                        # and no title
    
    # Close the device and hence save the file
    dev.off()
}