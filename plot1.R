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
## Q1:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.
##
## Graphic required: 
## bar chart showing each of the four years
############################################################################################

NEI_sub = NEI[NEI$year %in% c(1999, 2002, 2005, 2008) ,]
NEI_subtotal = aggregate(Emissions ~ year, NEI_sub, FUN=sum)

with(
	NEI_subtotal, 
	barplot
	(
		Emissions / 1000000, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abline(h = (NEI_subtotal[NEI_subtotal$year %in% 2008, 2] / 1000000), col="red")

png(filename='plot1.png')
with(
	NEI_subtotal, 
	barplot
	(
		Emissions / 1000000, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abline(h = (NEI_subtotal[NEI_subtotal$year %in% 2008, 2] / 1000000), col="red")
dev.off()