# Generate plot3 for Course Project 1

# We won't rewrite the file loading part but just source it in from plot1.R
source("plot1.R")

plot3 <- function() {
    #
    # Read the data from the file; download if necessary. The function 
    # readData() is defined in plot1.R and sourced in (see above). 
    #
    dt <- readData()
    
    #
    # Plot the data
    #
    
    # Open a PNG device
    pngDevice <- png(filename = "figure/plot3.png",
                     bg = "transparent",
                     width = 480, height = 480) # these are also the default
    
    # Create the plot
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Sub_metering_1,                # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  ylab = "Energy sub metering",      # only y label
                  xlab = "",                         # no x label
                  main = ""))                        # and no title
    with(dt, lines(x = Time, y = Sub_metering_2, type = "l", col = "red"))
    with(dt, lines(x = Time, y = Sub_metering_3, type = "l", col = "blue"))
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # Close the device and hence save the file
    dev.off()
}