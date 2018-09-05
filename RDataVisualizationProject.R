# Import the ggplot2 data.table libraries and use fread to load the csv file 
# 'Economist_Assignment_Data.csv' into a dataframe called df

library(ggplot2)
library(data.table)

df <- read.csv(file.choose(), stringsAsFactors = FALSE)
head(df)
df <- df[, -1]

# Check the head of df

head(df)

# Use ggplot() + geom_point() to create a scatter plot object called pl. 

pl <- ggplot(df, aes(x=CPI,y=HDI,color=Region)) + geom_point()
print(pl)

# Change the points to be larger empty circles

pl <- ggplot(df, aes(x=CPI,y=HDI,color=Region)) + geom_point(shape = 1, size = 4)
print(pl)

# Add the following arguments to geom_smooth (outside of aes): method = 'lm' formula = y ~ log(x)
# se = FALSE color = 'red'

pl2 <- pl + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
print(pl2)

# add labels

pl2 <- pl2 + geom_text(aes(label=Country))
print(pl2)

# selecting the subset of countries we want to label

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
print(pl3)

# add a theme

pl4 <- pl3 + theme_bw() 
pl4

# add x label

pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                                limits = c(.9, 10.5),breaks=1:10) 
pl5

# add y label

pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
pl6

# add a string as a title.

print(pl6 + ggtitle("Corruption and Human development"))

# add ggthemes

install.packages("ggthemes")
library(ggthemes)
pl6 + theme_economist_white()
