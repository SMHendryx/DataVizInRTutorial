require(graphics)
library(lattice)
require(lubridate)
require(ggplot2)
library(plotly)

#To set working directory in R:
#setwd("/Your/path/here")
#^path to data

#Or place data in same directory as script and do:
df <- read.csv(file="SRM AZ statistics_Lai_1km.asc")

#Create formatted time variables
dates <- as.Date(df$date)
Year <- format(dates, format = "%Y")
months <- format(dates, format = "%m")
DOY <- format(dates, format = "%j")
#If you want to add a "column" to your data frame do:
df$DOY <- DOY

#VISUALIZE
#Note plotly required as.numeric function
p <- ggplot(aes(as.numeric(DOY),LAImean), data=df) 

#Add fit line (smooth conditional mean) with 95% confidence interval
#Note that stat_smooth as opposed to geom_smooth has been used
p <- p + stat_smooth(aes(group = 1), method = "lm", formula= y ~ poly(x,4), level = .95)  
  #To set confidence interval to opaque include:
  #alpha = 1, 

#Colorize points by year
p <- p + geom_point(alpha=1, shape=21, aes(colour = Year, fill = Year), size=5)

#Add axis labels
p<- p + labs(title = "Average LAI of the Santa Rita Mesquite Savannah from MODIS by DOY over 15 years") +
  theme_bw() 
  #Manually adjust text size:
  #+ theme(axis.title = element_text(size = 18)) + theme(title = element_text(size = 20))

p <- p + labs(
    x = "Day Of Year",
    y = "Leaf Area Index"
  )


gg <- ggplotly(p)

gg

