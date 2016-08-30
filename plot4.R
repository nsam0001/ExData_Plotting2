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
## Q4:
## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?
##
## Graphic required: 
## same chart as before, showing just coal mining data (use SCC)
############################################################################################

SCC_CoalData = SCC[grepl("coal", tolower(SCC$Short.Name)), ]
SCC_CoalCodes = SCC_CoalData$SCC
NEI_Coal = NEI[NEI$SCC %in% SCC_CoalCodes, ]

NEI_Coaltotal = aggregate(Emissions ~ year, NEI_Coal, FUN=sum)

with(
	NEI_Coaltotal, 
	barplot
	(
		Emissions/1000000, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Coal-methods only)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abx = (NEI_Coaltotal[NEI_Coaltotal$year %in% 2008, 2])
abline(h = abx/1000000, col="red")

png(filename='plot4.png')
with(
	NEI_Coaltotal, 
	barplot
	(
		Emissions/1000000, 
		year, 
		main="Year-on-Year comparison of PM25 Emissions (Coal-methods only)", 
		names.arg = year, 
		xlab = "Year", 
		ylab = "Emissions (megatonne)"
	)
	)
abx = (NEI_Coaltotal[NEI_Coaltotal$year %in% 2008, 2])
abline(h = abx/1000000, col="red")
dev.off()