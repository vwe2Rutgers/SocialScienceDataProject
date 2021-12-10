library(jsonlite)
library(httr)
library(RedditExtractoR)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(dplyr)
library(RedditExtractoR)
library(devtools)
library(pushshiftR)
library(knitr)
library(stringr)
library(tidytext)
library(word2vec)
library(stm)
library(ggplot2)
library(viridis)
library(parallel)
library(reshape2)
library(magrittr)

#Gathering Reddit comments to build text corpora

edm <- find_thread_urls(sort_by = "top",subreddit = "ElectronicMusic",period = "year")
#filtering out inactive posts
edmMax <-edm %>% filter(comments > 10)
#checkin number of comments
edmsum <- edm %>% group_by(date_utc) %>% summarize(e.sum = sum(comments))
#Getting all the URLs
urlo <-edmMax$url
#Gathering thread contents to get comments and metadata
thread.contents <- lapply(urlo, get_thread_content)
#looping over thread.contents to filter out comments
EDM_comments <- tibble()
for (n in 1:length(thread.contents)) {
  EDM_comments <- rbind(comments, edm.thread.contents[[n]][[2]])
}

write.csv(EDM_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\EDM_comments.csv")

# data <- data %>% 
#   mutate(body = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", body)) %>% # Removing hashtags and mentions
#   mutate(body = gsub("(http[^ ]*)|(www.[^ ]*)", "", body)) %>% # Removing URLs
#   distinct(body, .keep_all =TRUE)
# 
# words <- data %>% unnest_tokens(word, body)
# 
# 
# data(stop_words) 
# stop_words <- stop_words %>% filter(lexicon == "snowball") # specifying snowball stopword lexicon
# words.2 <- words %>% anti_join(stop_words)
# 
# words.2 %>% count(word, sort = TRUE) %>%
#   slice(1:10) %>%
#   mutate(word = reorder(word, n)) %>%
#   ggplot(aes(n, word)) + geom_col() +
#   labs(y = NULL, x='Term frequency', title=paste("10 most frequent terms in corpus"))
# 
# top.terms <- words.2 %>% group_by(subreddit) %>% count(word, sort = TRUE) %>% top_n(10, n)
# 