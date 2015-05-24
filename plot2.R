#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data to Baltimore, Maryland by fips ID
MD <- subset(NEI, fips == '24510')

#Find total emissions per year for Baltimore, Maryland
totalEmissions<- aggregate(Emissions ~ year, data = MD, sum)

#Open up the PGN device
png(filename = "plot2.png", width = 480, height = 480)

#Plot data
plot(totalEmissions$Emissions ~ totalEmissions$year, type = "b", pch = 15, ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = expression("Total Annual Emissions in Baltimore, Maryland, PM"[2.5]))

# Close the PNG device
dev.off()


