## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(NEI, fips == "24510")
data$type <- as.factor(data$type)

## Plotting
library(plyr)
library(ggplot2)
png("plot3.png", width = 800, height = 480)
data <- ddply(data, .(year, type), summarise, totalEmissions = sum(Emissions))
q <- qplot(year, totalEmissions, data = data, facets = .~type, ylab = "Total Emissions", color = type)
q + geom_path()
dev.off()
