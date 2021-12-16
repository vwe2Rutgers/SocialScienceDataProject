library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)
library(RedditExtractoR)
library(SentimentalAnalysis)
library(SnowballC)
library(ggplot2)

library(devtools)
library(pushshiftR)



edm <- find_thread_urls(sort_by = "top",subreddit = "Electronic Music",period = "week")

edmMax <-edm %>%group_by(comments)%>% head(5)

urlo <-edmMax$url[[5]]

edmTrial <- get_thread_content(urlo)

edmTrial2 <-get_thread_content("https://www.reddit.com/r/Music/comments/r8te6k/songs_that_bands_played_live_before_they_were/")

write.csv(edmTrial2,"C:/Users/HP/Downloads/edmTrial4.csv")














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





sentimentRap <-analyzeSentiment(rap$value)

sentimentEDM <-analyzeSentiment(EDM$value)

sentimentCountry <-analyzeSentiment(country$value)

sentimentMusic <-analyzeSentiment(edmTrial2cs$comments.comment)





Rapcount <- countWords(rap$value,removeStopwords = FALSE)
Rapdataset <- bind_cols(rap,sentimentRap,Rapcount)

ggplot(Rapdataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample Rap Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)


EDMcount <- countWords(EDM$value,removeStopwords = FALSE)
EDMdataset <- bind_cols(EDM,sentimentEDM,EDMcount)

ggplot(EDMdataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample EDM Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)



Countrycount <- countWords(country$value,removeStopwords = FALSE)
Countrydataset <- bind_cols(country,sentimentCountry,Countrycount)

ggplot(Countrydataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample Country Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)




Rapdataset$value <-"Rap"

Countrydataset$value <- "Country"

EDMdataset$value <- "EDM"

all_genres <-bind_rows(Rapdataset,Countrydataset,EDMdataset)









