# Time Series of Daily Closing Stock Prices
# Authored by Sean Hendryx

library(plotly)

#Set working directory
setwd("/Users/seanhendryx/Google Drive/DataVizPresentation")

#Read data into R
data <- read.table("historicalCloses", header = TRUE, sep="")
aapl <- data$AAPL
goog <- data$GOOG
msft <- data$MSFT
date <- data$Date

#Axis label names:
xAxisLabel <- list(
  title = "Date")
yAxisLabel <- list(
  title = "Adj Close (USD)")

#Plot data
p <- plot_ly(x =date, y = aapl,
	name = "Apple Adjusted Closing Price",
	line = list(
		color = "rgb(0,255,0)"))

p <- add_trace(p, x = date, y = goog,
  name = "Google Adjusted Closing Price",
  line = list(color = "rgb(255,0,0)"))

p <- add_trace(p, x = date, y = msft,
	name = "Microsoft Adjusted Closing Price",
	line = list (color = "rgb(0,0,255)"))

p <- p %>%
  layout(title = "Daily Adjusted Closing Prices", xaxis = xAxisLabel, yaxis = yAxisLabel)
  
p