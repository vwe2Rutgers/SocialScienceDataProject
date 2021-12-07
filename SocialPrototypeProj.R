library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)
library(RedditExtractoR)
library(SentimentalAnalysis)
library(devtools)
library(pushshiftR)

#write.csv(EdmSet,"C:/Users/Vineet Ekka/Desktop/Edmset.csv")

#RedditExtractoR::get_thread_content()

#RedditExtractoR::find_thread_urls("EDM")



edm <- find_thread_urls(sort_by = "top",subreddit = "Electronic Music",period = "week")
urls <-edm$url[[5]]
edmCom <- get_thread_content(urls)

com<-edm$comments
comments <- com$comment






edmGO<-getPushshiftData(postType = "comment",
                           size = 100,
                           after = "1637841600",
                           subreddit = "electronicmusic",
                           nest_level = 1)


EDMGO <-getPushshiftData(postType = "comment",
                          size = 100,
                          after = "1546300800",
                          subreddit = "EDM",
                          nest_level = 1)




