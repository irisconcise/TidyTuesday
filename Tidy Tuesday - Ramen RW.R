library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)

ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")

ramen_ratings[is.na(ramen_ratings)] <- 0

#ramen_ratings

summary(ramen_ratings)
# Group By ----------------------------------------------------------------
ramen_group<-
  ramen_ratings %>%
  group_by(country) %>%
  summarize(Rating=round(mean(stars),2),number=n())%>%
  arrange(desc(Rating))%>%
  top_n(20,Rating)

ramen_group

mean(ramen_group$Rating)

graph<-ggplot(ramen_group, aes(x=reorder(country,+Rating),y=Rating,label=Rating))+
  geom_col(aes(fill=number))+
  scale_fill_distiller(palette=7,direction=1,name="Number of Ratings")+ theme_dark()+
  geom_hline(yintercept = mean(ramen_ratings$stars), color="blue",size=1.5,lty=3)+
  xlab("Country")+
  ylab("Average Star Rating")+
  ggtitle("Average Ramen Star Rating\n by Top 20 Countries")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(expand =c(0,0),limits=c(0, 5))+
  coord_flip()+
  geom_text(size=3.5,nudge_y= -2, color="black") + 
  theme(axis.text.x=element_text(angle = 0))+
  theme(axis.text.y=element_text(angle = 0))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())


graph

