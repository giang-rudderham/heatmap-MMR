# Heat Map
# MMR 
####################
library(ggplot2)
library(reshape2) # for melt function
library(scales) # for muted function

data <- read.csv("mmr-developed.csv",
                 stringsAsFactors = F, check.names = F)
average <- data[c(47, 48), ]

new.data <- melt(average, id.vars = "Country", variable.name = "year",
                 value.name = "pop")

p <- ggplot(new.data, aes(x = year, y = Country, fill = pop))
p + geom_raster() +
  scale_fill_gradient2(midpoint = mean(new.data$pop), low = muted("blue"), 
                       mid = "white",
                       high = muted("red"), space = "rgb", 
                       na.value = "grey50", guide = "legend") +
  xlab("Year") + 
  theme(axis.title.y = element_text(angle = 0)) +
  ggtitle("Maternal Mortality Ratio Per 100,000 Live Births
          \n Developing and Developed Countries") +
  labs(fill = "MMR")

ggsave("mmr-developing-developed.png", width = 13, height = 6.5, 
       dpi = 300)

