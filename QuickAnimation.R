#Load libraries
library(tidyverse)
library(gganimate)
library(ggthemes)

#Read table and convert it into longer format
nepal <- read_csv("NepalFish.csv")%>% pivot_longer(cols = 2:51,
                                                   names_to = "Year",
                                                   values_to = "Production")


#Animation and save as gif
P<- nepal %>%
  ggplot(aes(x=reorder(Species, Production), y= Production, fill=Species))+
  geom_col()+
  theme_wsj()+
  theme(legend.position = "none")+
  coord_flip()+
  geom_text(nepal, mapping=aes(min(Species), min(Production), label=as.factor(Year)),
            hjust=-2.5, vjust = 6.5, alpha = 0.2,  col = "gray", size = 15)+
  transition_time(as.numeric(Year))
P1 <- animate(P, renderer = gifski_renderer())  
anim_save("P1.gif")



