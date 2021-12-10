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



edm <- find_thread_urls(sort_by = "top",subreddit = "ElectronicMusic",period = "year")
#filtering out inactive posts
edmMax <-edm %>% filter(comments > 10)
#checkin number of comments
edmsum <- edm %>% group_by(date_utc) %>% summarize(e.sum = sum(comments))
#Getting all the URLs
urlo <-edmMax$url
#Gathering thread contents to get comments and metadata
edm.thread.contents <- lapply(urlo, get_thread_content)
#looping over thread.contents to filter out comments
EDM_comments <- tibble()
for (n in 1:length(thread.contents)) {
  EDM_comments <- rbind(comments, edm.thread.contents[[n]][[2]])
}

write.csv(EDM_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\EDM_comments.csv")


#edmTrial <- get_thread_content(urlo)
# edmTrial2 <-get_thread_content("https://www.reddit.com/r/Music/comments/r8te6k/songs_that_bands_played_live_before_they_were/")
# write.csv(edmTrial2,"C:/Users/HP/Downloads/edmTrial4.csv")
# sentiment <- analyzeSentiment(edmTrial2cs$comments.comment)












