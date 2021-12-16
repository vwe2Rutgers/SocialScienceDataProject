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

EDM_comments <- EDM_comments %>% mutate(comment = str_replace_all(EDM_comments$comment, "[^[:alnum:]]", " "))

EDM_comments <- EDM_comments %>% filter(validUTF8(comment) == TRUE)


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

rap_comments <- rap_comments %>% mutate(comment = str_replace_all(rap_comments$comment, "[^[:alnum:]]", " "))

rap_comments <- rap_comments %>% filter(validUTF8(comment) == TRUE)

write.csv(rap_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\rap_comments.csv")
```


Now doing it for the indie subreddit.
```{r Gathering Country Comments}
indie <- find_thread_urls(sort_by = "top", subreddit = "indie", period = "all")
#filtering out inactive posts
indieMax <-indie %>% filter(comments > 10)
#checkin number of comments
indiesum <- indieMax %>% summarize(c.sum = sum(comments))
#Getting all the URLs
urlo.2 <-indieMax$url %>% as.list()
#Gathering thread contents 
thread.contents.2 <- lapply(urlo.2, get_thread_content)
#looping over thread.contents to filter out comments and metadata
indie_comments <- tibble()
for (n in 1:length(thread.contents.2)) {
  indie_comments <- rbind(indie_comments, thread.contents.2[[n]][[2]])
}
#Making a subreddit name column so I can group by it 
indie_comments <- cbind(SubReddit = rep("Indie"), indie_comments)

indie_comments <- indie_comments %>% mutate(comment = str_replace_all(indie_comments$comment, "[^[:alnum:]]", " "))

indie_comments %>% filter(validUTF8(comment) == TRUE)
indie_comments <- indie_comments %>% filter(comment != "deleted")

write.csv(indie_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\indie_comments.csv")

```

Doing it for the jazz subreddit
```{r}
jazz <- find_thread_urls(sort_by = "top", subreddit = "jazz", period = "year")
#filtering out inactive posts
jazzMax <-jazz %>% filter(comments > 10)
#checkin number of comments
jazzsum <- jazzMax %>% summarize(c.sum = sum(comments))
#Getting all the URLs
urlo.3 <-jazzMax$url %>% as.list()
#Gathering thread contents 
thread.contents.3 <- lapply(urlo.3, get_thread_content)
#looping over thread.contents to filter out comments and metadata
jazz_comments <- tibble()
for (n in 1:length(thread.contents.3)) {
  jazz_comments <- rbind(jazz_comments, thread.contents.3[[n]][[2]])
}
#Making a subreddit name column so I can group by it 
jazz_comments <- cbind(SubReddit = rep("jazz"), jazz_comments)

jazz_comments <- jazz_comments %>% mutate(comment = str_replace_all(jazz_comments$comment, "[^[:alnum:]]", " "))

jazz_comments %>% filter(validUTF8(comment) == TRUE)

write.csv(jazz_comments, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\jazz_comments.csv")

```

code for later
```{r NLP Code for Later}



rap_data <- rap_comments %>%
  mutate(comment = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", comment)) %>% # Removing hashtags and mentions
  mutate(comment = gsub("(http[^ ]*)|(www.[^ ]*)", "", comment)) %>% # Removing URLs
  distinct(comment, .keep_all =TRUE)

words <- rap_data %>% unnest_tokens(word, comment)

#Cleaning the data and counting the words.
EDM_data <- EDM_comments %>%
  mutate(comment = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", comment)) %>% # Removing hashtags and mentions
  mutate(comment = gsub("(http[^ ]*)|(www.[^ ]*)", "", comment)) %>% # Removing URLs
  distinct(comment, .keep_all =TRUE)

words1 <- EDM_data %>% unnest_tokens(word, comment)

jazz_data <- jazz_comments %>%
  mutate(comment = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", comment)) %>% # Removing hashtags and mentions
  mutate(comment = gsub("(http[^ ]*)|(www.[^ ]*)", "", comment)) %>% # Removing URLs
  distinct(comment, .keep_all =TRUE)

words2 <- jazz_data %>% unnest_tokens(word, comment)

indie_data <- indie_comments %>%
  mutate(comment = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", comment)) %>% # Removing hashtags and mentions
  mutate(comment = gsub("(http[^ ]*)|(www.[^ ]*)", "", comment)) %>% # Removing URLs
  distinct(comment, .keep_all =TRUE)

words3  <- indie_data %>% unnest_tokens(word, comment)


data(stop_words) 
stop_words <- stop_words %>% filter(lexicon == "snowball") # specifying snowball stopword lexicon
rap_words <- words %>% anti_join(stop_words)

data(stop_words) 
stop_words <- stop_words %>% filter(lexicon == "snowball") # specifying snowball stopword lexicon
EDM_words <- words1 %>% anti_join(stop_words)

data(stop_words) 
stop_words <- stop_words %>% filter(lexicon == "snowball") # specifying snowball stopword lexicon
jazz_words <- words2 %>% anti_join(stop_words)

data(stop_words) 
stop_words <- stop_words %>% filter(lexicon == "snowball") # specifying snowball stopword lexicon
indie_words <- words3 %>% anti_join(stop_words)

SentimentAnalysis::analyzeSentiment(jazz_words$word)
# 
# words.2 %>% count(word, sort = TRUE) %>%
#   slice(1:10) %>%
#   mutate(word = reorder(word, n)) %>%
#   ggplot(aes(n, word)) + geom_col() +
#   labs(y = NULL, x='Term frequency', title=paste("10 most frequent terms in corpus"))
# 
# top.terms <- words.2 %>% group_by(subreddit) %>% count(word, sort = TRUE) %>% top_n(10, n)
# 