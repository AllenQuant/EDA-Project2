## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- subset(NEI, fips == "24510")

## Plotting
data <- ddply(data, .(year), summarise, totalEmissions = sum(Emissions))
png('plot2.png', width=480, height=480)
plot(data$year, data$totalEmission, type = "l", ylab = "Emissions in Baltimore City", xlab = "Year")
dev.off()
