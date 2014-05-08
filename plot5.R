## This first line will likely take a few seconds. Be patient!
## Reading data...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

MotorRelated <- grep("On-Road", unique(SCC$EI.Sector), value = T)
split <- SCC$EI.Sector %in% MotorRelated
SCCMotor <- subset(SCC, split == T)$SCC
data <- subset(NEI, fips == "24510")
split <- data$SCC %in% SCCMotor
motor <- subset(data, split == T)

## Plotting
library(plyr)
png("plot5.png", width = 480, height = 480)
pm25 <- ddply(motor, .(year), summarise, totalEmissions = sum(Emissions))
plot(pm25$year,pm25$totalEmissions, xlab="Year", ylab = "Total Motor-Related Emission in Baltimore City", type = "l")
dev.off()

