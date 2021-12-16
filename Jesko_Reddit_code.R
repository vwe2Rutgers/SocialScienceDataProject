````{r setup, include = FALSE}
library(jsonlite)
library(rmarkdown)
library(httr)
library(readr)
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
library(SentimentAnalysis)
```

#Gathering Reddit comments to build text corpora
```{r Gathering EDM Comments}
edm <- find_thread_urls(sort_by = "top",subreddit = "ElectronicMusic",period = "year")
#filtering out inactive posts
edmMax <-edm %>% filter(comments > 15)
#checkin number of comments
edmsum <- edm %>% group_by(date_utc) %>% summarize(e.sum = sum(comments))
#Getting all the URLs
urlo <-edmMax$url %>% as.list()
#Gathering thread contents to get comments and metadata
edm.thread.contents <- lapply(urlo, get_thread_content)
#looping over thread.contents to filter out comments
EDM_comments <- tibble()
for (n in 1:length(edm.thread.contents)) {
  EDM_comments <- rbind(EDM_comments, edm.thread.contents[[n]][[2]])
}
#Making a subreddit name column so I can group by it
EDM_comments <- cbind(SubReddit = rep("EDM"), EDM_comments)

write.csv(EDM_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\EDM_comments.csv")
```

Doing it this time for the r/rap subreddit
```{r Gathering Rap Comments, message=FALSE, warning=FALSE}
rap <- find_thread_urls(sort_by = "top", subreddit = "rap", period = "year")
#filtering out inactive posts
rapMax <-rap %>% filter(comments > 15)
#checkin number of comments
rapsum <- rapMax %>% group_by(date_utc) %>% summarize(r.sum = sum(comments))
#Getting all the URLs
urlo.1 <-rapMax$url %>% as.list()
#Gathering thread contents to get comments and metadata
thread.contents.1 <- lapply(urlo.1, get_thread_content)
#looping over thread.contents to filter out comments
rap_comments <- tibble()
for (n in 1:length(thread.contents.1)) {
  rap_comments <- rbind(rap_comments, thread.contents.1[[n]][[2]])
}
#Making a subreddit name column so I can group by it
rap_comments <- cbind(SubReddit = rep("Rap"), rap_comments)

write.csv(rap_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\rap_comments.csv")
```


Now doing it for the country subreddit.
```{r Gathering Country Comments}
rock <- find_thread_urls(sort_by = "top", subreddit = "metal", period = "year")
#filtering out inactive posts
rockMax <-rock %>% filter(comments > 10)
#checkin number of comments
rocksum <- rockMax %>% summarize(c.sum = sum(comments))
#Getting all the URLs
urlo.2 <-rockMax$url %>% as.list()
#Gathering thread contents 
thread.contents.2 <- lapply(urlo.2, get_thread_content)
#looping over thread.contents to filter out comments and metadata
rock_comments <- tibble()
for (n in 1:length(thread.contents.2)) {
  rock_comments <- rbind(rock_comments, thread.contents.2[[n]][[2]])
}
#Making a subreddit name column so I can group by it 
rock_comments <- cbind(SubReddit = rep("Metal"), rock_comments)

write.csv(rock_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\rock_comments.csv")

```


code for later
```{r NLP Code for Later}

rap_comments <- read_csv("C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\rap_comments.csv", quote = "\"")
EDM_Comments <- read_csv("C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\EDM_comments.csv", quote = "\"")

#Making comments utf-8 compliant by filtering out non alphanumeric values
comments1 <- EDM_Comments %>% mutate(comment = str_replace_all(EDM_Comments$comment, "[^[:alnum:]]", " "))


comments2 <- rap_comments %>% mutate(comment = str_replace_all(rap_comments$comment, "[^[:alnum:]]", " "))

zz <- SentimentAnalysis::countWords(comments1$comment)


data <- comments1 %>%
  mutate(comment = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", comment)) %>% # Removing hashtags and mentions
  mutate(comment = gsub("(http[^ ]*)|(www.[^ ]*)", "", comment)) %>% # Removing URLs
  distinct(comment, .keep_all =TRUE)

words <- data %>% unnest_tokens(word, comment)

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