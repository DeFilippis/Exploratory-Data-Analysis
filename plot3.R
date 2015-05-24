#load ggplot library
library(ggplot2)

#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data to Baltimore, Maryland by Fips ID
MD <- subset(NEI, fips == 24510)

#Find total emissions per year for Baltimore, Maryland
aggregateByType <- aggregate(Emissions ~ type + year, data=MD, sum)

#Open up the PGN device for saving
png(filename='plot3.png', width=480, height=480)

#Plot data using ggplot
qplot(year, Emissions, data = aggregateByType, group = type, 
      color = type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Pollutant Type")

dev.off()