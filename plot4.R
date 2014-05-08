## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

CoalRelated <- grep("Coal", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% CoalRelated
SCCCoal <- subset(SCC, split == T)$SCC
split <- NEI$SCC %in% SCCCoal
coal <- subset(NEI, split == T)

## Plotting
library(plyr)
png("plot4.png", width = 480, height = 480)
pm25 <- ddply(coal, .(year), summarise, totalEmissions = sum(Emissions))
plot(pm25$year,pm25$totalEmissions, xlab="Year", ylab = "Total Coal-Related Emission", type = "l")
dev.off()
