#load ggplot library
library(ggplot2)

#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset data to include only Baltimore and LA Data
subset <- subset(NEI, fips == "06037" | fips == "24510")

#Subset SCC data to include Mobile Vehicle polution by EI.Sector
motorGrep <- SCC[grepl("vehicles", SCC$SCC.Level.Two, ignore.case = TRUE), ]

#Merge data based on motor vehicle pollution
merge <- merge(subset, motorGrep, by = "SCC")
merge.sum <- aggregate(Emissions ~ year + fips, data = merge, sum)

#Open the PGN device for saving
png(filename = "plot6.png", width = 480, height = 480)

#Plot the Data
ggplot(merge.sum, aes(year,Emissions)) + 
  geom_point(aes(color = fips))+ geom_line(aes(color = fips)) + 
  scale_color_discrete(name = "City", breaks = c("06037", "24510"), 
                       labels = c("Los Angeles", "Baltimore")) +
  labs(x = "Year") + labs(y = expression("Total Emissions, PM"[2.5])) + 
  labs(title = "Total Motor Vehicle Emissions in Baltimore and LA")


# Close the PNG device
dev.off()

