## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Plotting
data <- ddply(NEI, .(year), summarise, totalEmissions = sum(Emissions))
png('plot1.png', width=480, height=480)
plot(data$year, data$totalEmissions, type = "l", ylab = "Total Emissions", xlab = "Year")
dev.off()
