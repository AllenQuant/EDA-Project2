## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

MotorRelated <- grep("On-Road", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% MotorRelated
SCCMotor <- subset(SCC, split == T)$SCC
baltimore <- subset(NEI,fips == "24510")
la <- subset(NEI, fips == "06037")
split <- baltimore$SCC %in% SCCMotor
motorBaltimore <- subset(baltimore, split == T)
split <- la$SCC %in% SCCMotor
motorLa <- subset(la, split == T)

## Plotting
library(plyr)
library(ggplot2)
pm25Baltimore <- ddply(motorBaltimore, .(year), summarise, totalEmissions = sum(Emissions))
pm25La <- ddply(motorLa, .(year), summarise, totalEmissions = sum(Emissions))
pm25Baltimore$location <- "Baltimore"
pm25La$location <- "Los Angeles County"
data <- rbind(pm25La, pm25Baltimore)
png("plot6.png", width = 800, height = 480)
q <- qplot(year, totalEmissions, data = data, color = location, ylab = "Total Motor-Related Emission between Two City")
q + geom_path()
dev.off()
