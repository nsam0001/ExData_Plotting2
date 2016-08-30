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
## Q6:
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == "06037"). Which city has 
## seen greater changes over time in motor vehicle emissions?
##
## Graphic required: 
## same chart as before, latticed/trellised by town
############################################################################################

NEI_subBaltiLAMotor = NEI[((NEI$fips=="24510") | (NEI$fips == "06037")) & (toupper(NEI$type)=="ON-ROAD"), ]

NEI_subBaltiLAMotor_Clean = NEI_subBaltiLAMotor

NEI_subBaltiLAMotor_Clean$fips[NEI_subBaltiLAMotor_Clean$fips == "24510"] = "Baltimore"
NEI_subBaltiLAMotor_Clean$fips[NEI_subBaltiLAMotor_Clean$fips == "06037"] = "LA County"


library(ggplot2)

ggplot(
	data=NEI_subBaltiLAMotor_Clean, 
	aes(x=factor(year), y=Emissions)) + 
	facet_grid(. ~ fips) + 
	guides(fill=F) +
    geom_bar(stat="identity") + 
    ylab('Emissions (tonne)') + 
	xlab('Year') + 
    ggtitle('Year-on-Year comparison of PM25 Emissions (Baltimore & LA County)')

png(filename='plot6.png', width=1024, height=768, units='px')
ggplot(
	data=NEI_subBaltiLAMotor_Clean, 
	aes(x=factor(year), y=Emissions)) + 
	facet_grid(. ~ fips) + 
	guides(fill=F) +
    geom_bar(stat="identity") + 
    ylab('Emissions (tonne)') + 
	xlab('Year') + 
    ggtitle('Year-on-Year comparison of PM25 Emissions (Baltimore & LA County)')
dev.off()