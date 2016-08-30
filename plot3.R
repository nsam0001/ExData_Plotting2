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
