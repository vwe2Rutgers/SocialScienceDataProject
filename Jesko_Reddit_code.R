````{r setup, include = FALSE}
library(jsonlite)
library(rmarkdown)
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
  EDM_comments <- rbind(comments, edm.thread.contents[[n]][[2]])
}

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

write.csv(rap_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\rap_comments.csv")
```


Now doing it for the country subreddit.
```{r Gathering Country Comments}
country <- find_thread_urls(sort_by = "top", subreddit = "country", period = "year")
#filtering out inactive posts
countryMax <-country %>% filter(comments > 10)
#checkin number of comments
countrysum <- countryMax %>% group_by(date_utc) %>% summarize(c.sum = sum(comments))
#Getting all the URLs
urlo.2 <-countryMax$url %>% as.list()
#Gathering thread contents 
thread.contents.2 <- lapply(urlo.2, get_thread_content)
#looping over thread.contents to filter out comments and metadata
country_comments <- tibble()
for (n in 1:length(thread.contents.2)) {
  country_comments <- rbind(country_comments, thread.contents.2[[n]][[2]])
}

write.csv(country_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\country_comments.csv")

```


code for later
```{r NLP Code for Later}
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