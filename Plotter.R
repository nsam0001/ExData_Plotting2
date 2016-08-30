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
		round(Emissions / 1000000), 
		year, 
		main="Year-on-Year comparison of PM25 Emissions", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abline(h = NEI_subtotal[NEI_subtotal$year %in% 2008, 2], col="red")

png(filename='plot1.png')
with(
	NEI_subtotal, 
	barplot
	(
		Emissions, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abline(h = NEI_subtotal[NEI_subtotal$year %in% 2008, 2], col="red")
dev.off()

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

############################################################################################
## Q3:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
## ggplot2 plotting system to make a plot answer this question.
##
## Graphic required: 
## same concept, but trellis/lattice this across the source dimension
############################################################################################

library(ggplot2)

ggplot(
	data=NEI_subBalti, 
	aes(x=factor(year), y=Emissions)) + 
	facet_grid(. ~ type) + 
	guides(fill=F) +
    geom_bar(stat="identity") + 
    ylab('Emissions (tonne)') + 
	xlab('Year') + 
    ggtitle('Year-on-Year comparison of PM25 Emissions (Baltimore) by Source')

png(filename='plot3.png', width=1024, height=768, units='px')
ggplot(
	data=NEI_subBalti, 
	aes(x=factor(year), y=Emissions)) + 
	facet_grid(. ~ type) + 
	guides(fill=F) +
    geom_bar(stat="identity") + 
    ylab('Emissions (tonne)') + 
	xlab('Year') + 
    ggtitle('Year-on-Year comparison of PM25 Emissions (Baltimore) by Source')
dev.off()
