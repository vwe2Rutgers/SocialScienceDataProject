
library(jsonlite)
library(httr)
library(RedditExtractoR)
library(tidyverse)
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

rap <- getPushshiftData(postType = "comment",
                 size = 1000,
                 after = "1637841600",
                 subreddit = "rap",
                 nest_level = 1)
rap <- rap$body %>% as_tibble()

EDM <- getPushshiftData(postType = "comment",
                                   size = 1000,
                                   after = "1637841600",
                                   subreddit = "electronicmusic",
                                   nest_level = 1)

EDM <- EDM$body %>% as_tibble()

country <- getPushshiftData(postType = "comment",
                                   size = 1000,
                                   after = "1637841600",
                                   subreddit = "country",
                                   nest_level = 1)
country <- country$body %>% as_tibble()

data <- cbind(rap, EDM, country)

colnames(data) <- c("Rap", "EDM", "Country")


write.csv(data, "C:\\Users\\jesko\\Documents\\GitHub\\SocialScienceDataProject\\data.csv")

data <- data %>% 
  distinct(rap, .keep_all =TRUE) %>% 
  distinct(country, .keep_all = TRUE) %>% 
  distinct(EDM, .keep_all = TRUE)

worddd <- tibble(line = 1:100, text = data)
words <- worddd %>% unnest_tokens(word, text)

words %>% count(data, sort = TRUE) %>%
  slice(1:10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) + geom_col() +
  labs(y = NULL, x='Term frequency', title=paste("10 most frequent terms in corpus"))


unnest_tokens()
