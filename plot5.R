#load ggplot library
library(ggplot2)

#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get motor-vehicle pollution only, subset by md
MD <- subset(NEI, fips == 24510)
motorGrep <- SCC[grepl("vehicles", SCC$SCC.Level.Two, ignore.case = TRUE), ]
merge <- merge(MD, motorGrep, by = "SCC")
merge.sum <- aggregate(Emissions ~ year, data = merge, sum)

#Open the PGN device for saving
png(filename = "plot5.png", width = 480, height = 480)

#Plot the Data
ggplot(merge.sum, aes(year, Emissions)) + 
  geom_point(color = "blue") + geom_line() + 
  labs(x = "Year") + labs(y = expression("Total Emissions, PM"[2.5])) + 
  labs(title = "Total Motor Vehicle Emissions in Baltimore City")

# Close the PNG device
dev.off()