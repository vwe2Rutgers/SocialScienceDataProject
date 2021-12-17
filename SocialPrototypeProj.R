library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)
library(RedditExtractoR)
library(SentimentAnalysis)
library(SnowballC)
library(ggplot2)
library(readr)






Rapdataset$value <-"Rap"

Countrydataset$value <- "Country"

EDMdataset$value <- "EDM"

all_genres <-bind_rows(Rapdataset,Countrydataset,EDMdataset)



jazz_comments <- read.csv("C:/Users/HP/Downloads/jazz_comments.csv")

indie_comments <- read.csv("C:/Users/HP/Downloads/indie_comments.csv")

edm_comments < -read.csv("C:/Users/HP/Downloads/edm_comments.csv")


N <-30000


rap_comments <- read.csv("C:/Users/HP/Downloads/rap_comments.csv")

rap_commentsSub <-sample_n(rap_comments,N)






sentimentRap <-analyzeSentiment(rap_commentsSub$comment)
Rapcount <- countWords(rap_commentsSub$comment,removeStopwords = TRUE)
Rapdataset <-bind_cols(rap_commentsSub$SubReddit,sentimentRap,Rapcount)
ggplot(Rapdataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample Rap Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)



sentimentJazz <-analyzeSentiment(jazz_comments$comment)
Jazzcount <- countWords(jazz_comments$comment,removeStopwords = TRUE)

jazzdataset <- bind_cols(jazz_comments$SubReddit,sentimentJazz,Jazzcount)
ggplot(jazzdataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample Jazz Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)



sentimentIndie <-analyzeSentiment(indie_comments$comment)
Indiecount <- countWords(indie_comments$comment,removeStopwords = TRUE)
Indiedataset <- bind_cols(indie_comments$SubReddit,sentimentIndie,Indiecount)
ggplot(Indiedataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample Indie Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)




sentimentEDM  <-analyzeSentiment(edm_comments$comment)
EDMcount <- countWords(edm_comments$comment,removeStopwords = TRUE)
EDMdataset <- bind_cols(edm_comments$SubReddit,sentimentEDM,EDMcount)
ggplot(EDMdataset,aes(x=SentimentGI)) +
  ggtitle("Sentiment of Sample EDM Subreddit Data") +
  geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)



all_genres <-bind_rows(Rapdataset,jazzdataset,EDMdataset,Indiedataset)


IndieControl <- bind_cols(sentimentIndie,indie_comments)

plotSentimentResponse(IndieControl$SentimentGI,IndieControl$score,ylab = "Comment Score", smoothing = "lm")


EDMControl <- bind_cols(sentimentEDM,edm_comments)
plotSentimentResponse(EDMControl$SentimentGI,EDMControl$score,ylab = "Comment Score", smoothing = "lm")


RapControl <- bind_cols(sentimentRap,rap_commentsSub)
plotSentimentResponse(RapControl$SentimentGI,RapControl$score,ylab = "Comment Score", smoothing = "lm")


JazzControl <- bind_cols(sentimentJazz,jazz_comments)
plotSentimentResponse(JazzControl$SentimentGI,JazzControl$score,ylab = "Comment Score", smoothing = "lm")

JazzControl2 <-bind_cols(jazz_comments,JazzControl)

plotSentimentResponse(JazzControl2$SentimentGI,JazzControl2$score...6,ylab = "Comment Score", smoothing = "lm")

IndieControl2 <- bind_cols(indie_comments,IndieControl)

RapControl2 <- bind_cols(rap_commentsSub,RapControl)

EDMControl2 <- bind_cols(edm_comments,EDMControl)

all_genresComments <- bind_rows(RapControl2,EDMControl2,IndieControl2,JazzControl2)

plotSentimentResponse(all_genresComments$SentimentGI,all_genresComments$score...6,ylab = "Comment Score", smoothing = "lm")












#g

