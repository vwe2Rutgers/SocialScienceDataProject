---
#Jesskomar Velarde Gargot 
#prototpe code for spotify API
---
install.packages("geniusr")
library(geniusr)
library(spotifyr)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(ggplot2)
library(rvest)
library(stringr)
library(magrittr)
library(reshape2)
library(parallel)


#Spotify Creds
creds <- read_json("SpotifyCreds.json") 

Sys.setenv(SPOTIFY_CLIENT_ID = creds$id) 
Sys.setenv(SPOTIFY_CLIENT_SECRET = creds$secret)

access_token <- get_spotify_access_token

#genius Creds
genius_token <- function(force = FALSE)
{
env <- Sys.setenv('kYKnu6jb5qu0ZEEcuA1jsvKVSbw45fgAH00ct-HcIVbziF3Hl9slWHmyESTiN1Eo') #replace with your own Genius token
if (!identical(env, "") && !force) return(env)

if (!interactive()) {
  stop("Please set env var GENIUS_API_TOKEN to your Genius API key",
       call. = FALSE)
}

message("Couldn't find env var GENIUS_API_TOKEN See ?genius_token for more details.")
message("Please enter your Genius Client Access Token and press enter:")
pat <- readline(": ")

if (identical(pat, "")) {
  stop("Genius API key entry failed", call. = FALSE)
}

message("Updating GENIUS_API_TOKEN env var to PAT")
Sys.setenv(GENIUS_API_TOKEN = pat)

pat
}

#Making a list of names to pass through the genius search function
artists <- get_genre_artists(genre = "country")
Nombres <- artists$name %>% as_tibble()

#Trying to make a list of artists and their IDs
A <- tibble()
t <- character()
ids <- character()
N <- character()

for (z in 1:nrow(Nombres)) {
  t <- rbind(t, search_artist(Nombres[z,]))
 ids <- t$artist_id
 N <- t$artist_name
}

#code to make those id's into a list of tracks 
songs <- tibble()

for (i in seq_along(ids)) {

  lyrics_urls <- songs$song_lyrics_url
  songs <- rbind(songs, get_artist_songs_df(ids[i]))
}

#Gathering Lyrics
lyrics <- tibble()

#Having trouble collecting all the lyrics in one shot, seems as though either my laptop can't handle it, or the server is too slow.
for (l in seq_along(lyrics_urls)) {
  lyrics <- rbind(lyrics, get_lyrics_url(lyrics_urls[l]))
  
}
#Attempt at making a more efficient method of getting the lyrics.
sapply(lyrics_urls, get_lyrics_url)

#I am going to attempt to parallelize it and see if that changes anything
{numCores <- detectCores()
  cl <- makeCluster(numCores)
  clusterEvalQ(cl, library(geniusr))
  saver <- parSapply(cl, lyrics_urls, get_lyrics_url)
  stopCluster(cl)}

#it worked, but it got me an empty matrix of lyric values. I'm not quite sure what caused that. 


