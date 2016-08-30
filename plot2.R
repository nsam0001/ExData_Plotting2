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
## Q2:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
## answering this question.
##
## Graphic required: 
## same chart as before, showing just Balitmore data
############################################################################################

NEI_subBalti = NEI[NEI$fips == "24510" ,]
NEI_subBaltitotal = aggregate(Emissions ~ year, NEI_subBalti, FUN=sum)

with(
	NEI_subBaltitotal, 
	barplot
	(
		round(Emissions), 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Baltimore)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (tonne)"
	)
	)
abline(h = NEI_subBaltitotal[NEI_subBaltitotal$year %in% 2008, 2], col="red")

png(filename='plot2.png')
with(
	NEI_subBaltitotal, 
	barplot
	(
		Emissions, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Baltimore)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (tonne)"
	)
	)
abline(h = NEI_subBaltitotal[NEI_subBaltitotal$year %in% 2008, 2], col="red")
dev.off()