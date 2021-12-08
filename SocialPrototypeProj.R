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



edm <- find_thread_urls(sort_by = "top",subreddit = "Electronic Music",period = "week")

edmMax <-edm %>%group_by(comments)%>% head(5)

urlo <-edmMax$url[[5]]

edmTrial <- get_thread_content(urlo)

edmTrial2 <-get_thread_content("https://www.reddit.com/r/Music/comments/r8te6k/songs_that_bands_played_live_before_they_were/")

write.csv(edmTrial2,"C:/Users/HP/Downloads/edmTrial4.csv")

sentiment <- analyzeSentiment(edmTrial2cs$comments.comment)







urls <- edm$url[[8]]
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




