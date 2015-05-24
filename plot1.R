
#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find emission sum by year
totalEmissions <- aggregate(Emissions ~ year, data = NEI, sum)

##Save output to PGN
png(filename = "plot1.png", width = 480, height = 480)


#Plot data
plot(totalEmissions$Emissions ~ totalEmissions$year, type = "b", pch = 15, ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = expression("Total Emissions, PM"[2.5]))

# Close the PNG device
dev.off()

