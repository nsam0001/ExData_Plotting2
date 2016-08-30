############################################################################################
## INIT
############################################################################################

setwd("C:\\Users\\NS186041.TD\\Documents\\GitHub\\ExData_Plotting2\\")

############################################################################################
## Data Ingest
############################################################################################

NEI = readRDS("C:\\Users\\NS186041.TD\\Documents\\EDA02\\summarySCC_PM25.rds")
SCC = readRDS("C:\\Users\\NS186041.TD\\Documents\\EDA02\\Source_Classification_Code.rds")

############################################################################################
## Data Summary
############################################################################################

summary(NEI)
dim(NEI)
names(NEI)
head(NEI)

summary(SCC)
dim(SCC)
names(SCC)
head(SCC)

############################################################################################
## Q5:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
##
## Graphic required: 
## same chart as before, showing just Balitmore data
############################################################################################

NEI_subBaltiMotor = NEI[(NEI$fips=="24510") & (toupper(NEI$type)=="ON-ROAD"), ]
NEI_subBaltiMotortotal = aggregate(Emissions ~ year, NEI_subBaltiMotor, FUN=sum)

with(
	NEI_subBaltiMotortotal, 
	barplot
	(
		round(Emissions), 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Baltimore, ON-ROAD)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (tonne)"
	)
	)
abline(h = NEI_subBaltiMotortotal[NEI_subBaltiMotortotal$year %in% 2008, 2], col="red")

png(filename='plot5.png')
with(
	NEI_subBaltiMotortotal, 
	barplot
	(
		round(Emissions), 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Baltimore, ON-ROAD)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (tonne)"
	)
	)
abline(h = NEI_subBaltiMotortotal[NEI_subBaltiMotortotal$year %in% 2008, 2], col="red")
dev.off()