# Final analysis ----

# Data sourced ----
Data<-read.csv("/Users/Downloads/CC-4-Datavis-master/LPIdata_CC.csv")

# Libraries used ---
library(tidyr)
library(readr)
library(dplyr)
library(ggplot2)
library(RCurl)

# Data transformations ----
DataFix<-gather(Data,"year","abundance",9:53)

DataFix$year <- parse_number(DataFix$year)

names(DataFix)
names(DataFix) <- tolower(names(DataFix))

DataFix$abundance <- as.numeric(DataFix$abundance)

lpiBiomes<- DataFix %>%group_by(biome)%>%summarise(Pop. = n())
lpiBiomes[1:5,1:2]

# Functions ----
ThemeForLPI <- function() { 
  theme_bw()+
  theme(axis.text.x=element_text(size=12, angle=45, vjust=1, hjust=1), 
        axis.text.y=element_text(size=12),
        axis.title.x=element_text(size=14, face="plain"), 
        axis.title.y=element_text(size=14, face="plain"), 
        panel.grid.major.x=element_blank(), 
        panel.grid.minor.x=element_blank(), 
        panel.grid.minor.y=element_blank(), 
        panel.grid.major.y=element_blank(),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
        plot.title = element_text(size=20, vjust=1, hjust=0.5),
        legend.text = element_text(size=12, face="italic"),legend.title = element_blank(),legend.position=c(0.9, 0.9))}

levels(DataFix$biome)

# different graphs ----
type = "bar"
plot <- ggplot(DataFix, aes(biome, color = biome)) + 
  {if(type=="bar")geom_bar() else geom_point(stat="count")} +
	ThemeForLPI() + ylab("Number of populations") + xlab("Biome") +
	theme(legend.position = "none")

plot  # plot the ggplot plot

type = "point"
plot <- ggplot(DataFix, aes(biome, color = biome)) + 
  {if(type == "bar") geom_bar() else geom_point(stat = "count")} +
	ThemeForLPI() + ylab("Number of populations") + xlab("Biome") +
	theme(legend.position = "none")

plot
type = "bar"
pdf(file="plot1.pdf",  width = 13.33, height = 26.66)
ggplot(DataFix, aes(biome, color = biome)) + 
  {if(type=="bar")geom_bar() else geom_point(stat="count")} +
	ThemeForLPI() + ylab("Number of populations") + xlab("Biome") +
	theme(legend.position = "none") 

dev.off()



