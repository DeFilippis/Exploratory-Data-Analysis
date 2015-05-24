#load ggplot library
library(ggplot2)

#Read in Data into Data Frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Get coal-combusted sources only
coalGrep <- SCC[grepl("Coal", SCC$Short.Name), ]
coalNEI <- merge(NEI, coalGrep, by = "SCC")
coalSum <- aggregate(Emissions ~ year, data = coalNEI, sum)

#Open the PGN device for saving
png(filename = "plot4.png", width = 480, height = 480)

#Plot Data
ggplot(coalSum, aes(year, Emissions)) + 
  geom_point(color = "blue") + geom_line() + labs(x = "Year") + 
  labs(y = expression("Total Emissions, PM"[2.5])) + 
  labs(title = "Coal Combustion Emissions in the US")

#Close PGN Device
dev.off()