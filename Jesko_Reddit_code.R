
library(jsonlite)
library(httr)
library(RedditExtractoR)
library(tidyverse)
library(devtools)
library(pushshiftR)

# hhop <-get_reddit(subreddit = "hiphop", page_threshold = 3, sort_by = "comments")
# install.packages("sentimentanalysis")
# red <- find_thread_urls(subreddit = "hiphop")
# urls <- as_tibble(red$url)
# rap <- get_thread_content(urls)
# com <- rap$comments
# comments <- com$comment
#get rid of mod and auto mod comments
# 
# Urls <- sapply(urls, get_thread_content)
# as.data.frame(Urls)
# class(Urls)

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


