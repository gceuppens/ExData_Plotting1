# Generate plot4 for Course Project 1

# We won't rewrite the file loading part but just source it in from plot1.R
source("plot1.R")

plot4 <- function() {
    #
    # Read the data from the file; download if necessary. The function 
    # readData() is defined in plot1.R and sourced in (see above). 
    #
    dt <- readData()
    
    #
    # Plot the data
    #
    
    # Open a PNG device
    # -- Note that the background in the example pictures is transparent, not
    #    white!
    pngDevice <- png(filename = "figure/plot4.png",
                     bg = "transparent",
                     width = 480, height = 480) # these are also the default

    # We will use a 2x2 grid here and fill it row by row:
    par(mfrow = c(2,2))
    
    # Now create the plots
    
    # Top left (same as plot 2 although y label slightly different):
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Global_active_power,           # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  ylab = "Global Active Power",      # only y label
                  xlab = "",                         # no x label
                  main = ""))                        # no title
    
    # Top right:
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Voltage,                       # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  ylab = "Voltage",                  # y label
                  xlab = "datetime",                 # x label
                  main = ""))                        # no title
    
    # Bottom left (same as plot 3 but note the legend has no box now!)
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Sub_metering_1,                # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  ylab = "Energy sub metering",      # only y label
                  xlab = "",                         # no x label
                  main = ""))                        # and no title
    with(dt, lines(x = Time, y = Sub_metering_2, type = "l", col = "red"))
    with(dt, lines(x = Time, y = Sub_metering_3, type = "l", col = "blue"))
    # box.lwd of zero means no box around the legend, lty = 1 is required for
    # a line graph else the legend won't show
    legend("topright", lty = 1, box.lwd = 0,         
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # Bottom right:
    with(dt, plot(x = Time,                          # Horizontal axis
                  y = Global_reactive_power,         # Vertical axis
                  type = "l",                        # line plot
                  col = "black",                     # line in black colour
                  #ylab = "Global Active Power (kilowatts)",  # only y label
                  xlab = "datetime",                 # x label
                  main = ""))                        # no title
        
    # Close the device and hence save the file
    dev.off()
}