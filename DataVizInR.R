# Install packages if you need to
# install.packages(c("ggplot2", "dplyr", "tidyr"))
library(ggplot2)
library(dplyr)
library(tidyr)



# Plots used during grammar of graphics discussion
g <- ggplot(data = mtcars, aes(x = wt, y = mpg))
g + geom_point()
g + geom_point() + facet_grid(cyl ~ .)

g2 <- ggplot(data = mtcars, aes(x = mpg))
g2 + stat_bin()
# Is the same as
g2 + geom_bar(stat = "bin")
# Which is the same as
g2 + geom_histogram()

g3 <- ggplot(data = mtcars, aes(x = 1, fill = factor(cyl)))
g3 + geom_bar() + coord_polar(theta = "y")
g3 + geom_bar() + coord_polar(theta = "y") + theme(axis.text = element_blank(),
                                                   axis.ticks = element_blank(),
                                                   panel.grid = element_blank(),
                                                   axis.title.y = element_blank(),
                                                   panel.background = element_blank(),
                                                   axis.title.x = element_blank())


# Let's build some vizzes section
# Basic Scatterplots
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point()
ggplot(data = mtcars, aes(x = wt, y = mpg)) + geom_point() + geom_smooth(se = FALSE)
ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(am))) + geom_point()
ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(am), shape = factor(am))) + geom_point()

# Dealing with overplotting on a scatterplot
d <- ggplot(data = diamonds, aes(x = carat, y = price))
d + geom_point()
d + geom_jitter(width = .1)
# alpha sets the transparency. When you use a fraction, 
# the bottom number is the number of points that have to overlap to make a solid point
d + geom_point(alpha = 1/20)
d + geom_point(alpha = 1/50)
d + geom_point(alpha = 1/100)

# bar charts
ggplot(data = mtcars, aes(x = cyl)) + geom_bar()
ggplot(data = mtcars, aes(x = cyl)) + geom_bar(fill = "blue")

b <- ggplot(data = mtcars, aes(x = cyl, fill = factor(gear)))
b + geom_bar()
b + geom_bar(position = "dodge")
b + geom_bar(position = "fill")
b + geom_bar(position = position_dodge(width = 0.2), alpha = 0.5)

# Histograms, frequecy polygons, boxplots, and violin plots
h <- ggplot(data = diamonds, aes(x = depth)) + xlim(55, 70)
h + geom_histogram()
h + geom_histogram(binwidth = 0.1)
h + geom_histogram(bins = 150)
h1 <- ggplot(data = diamonds, aes(x = cut, y = price))
h1 + geom_boxplot()
h1 + geom_violin()

# Comparing multiple histograms
ggplot(data = diamonds, aes(x = depth, fill = cut)) + geom_histogram() + xlim(55, 70)
ggplot(data = diamonds, aes(x = depth, color = cut))+ geom_freqpoly(size = 1) + xlim(55, 70)
# or
ggplot(data = diamonds, aes(x = depth)) + geom_histogram(binwidth = 0.1) + xlim(55, 70) + 
  facet_grid(cut ~ .)

# Line and area charts
ggplot(data = economics, aes(x = date, y = uempmed)) + geom_line()
recessions <- data.frame(begin = as.Date(as.character(c("1969-12-01", "1973-11-01", "1980-01-01", "1981-07-01", "1990-07-01", "2001-03-01"), format = "%Y/%m/%d")),
                                   end = as.Date(as.character(c("1970-11-01", "1975-03-01", "1980-07-01", "1982-11-01", "1991-03-01", "2001-11-01"), format = "%Y/%m/%d")))
ggplot(data = economics, aes(x = date, y = unemploy/pop)) + geom_line() + 
  geom_rect(data = recessions, aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf), 
            inherit.aes = FALSE, fill = "red", alpha = 0.2)
ggplot(data = economics_long, aes(x = date, y = value01, color = variable)) + geom_line()

economics2 <- filter(economics_long, variable == c("psavert", "pce"))
ggplot(data = economics2, aes(x = date, y = value01, color = variable, linetype = variable)) + 
  geom_line(size = 1)

areaData <- data.frame(group = factor(c(rep("one",5), rep("two", 5), rep("three", 5)), levels = c("one", "two", "three")), 
                       measurement = c(1,2,3,4,5,1,2,3,4,5,1,2,3,4,5), value = c(1,2,3,2.5,5, 1,2.2, 2.4, 3.5, 5.2, 1.4, 2.3, 4, 5.4,5))
ggplot(data = areaData, aes(x = measurement, y = value, fill = group)) + geom_area()

# Heatmap
pData <- data.frame(i = c(1, 2, 3, 4, 5), j1 = c(NA, 0.065, 0.0067, 0.9616, 0.9953), j2 = c(0.0065, NA, 1, 0.0003, 0.0460), j3 = c(0.0067, 1, NA, 0.004, 0.0475),
                    j4 = c(0.9616, 0.0003, 0.0004, NA, 0.5819), j5 = c(0.9953, 0.0460, 0.0475, 0.5819, NA))
head(pData)
pData2 <- gather(data = pData, key = j, value = pValue, -i)

pData2$j <- gsub(pattern = "j", x = pData2$j, replacement ="")
pData2$sig <- pData2$pValue <= 0.05
head(pData2)

heatmap <- ggplot(data = pData2, aes(x = j, y = factor(i), fill = sig)) + geom_tile(color = "black") + geom_text(aes(label = pValue)) + 
  scale_fill_manual(values = c("Red", "Green")) + labs(title = "Significance Map", x = "j", y = "i", fill = "Signficant")
heatmap
heatmap + theme_minimal()
heatmap + theme(plot.title = element_text(size = 20), axis.title = element_text(size = 20), panel.background = element_blank())
