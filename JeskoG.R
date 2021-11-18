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

creds <- read_json("SpotifyCreds.json") # read creds

Sys.setenv(SPOTIFY_CLIENT_ID = creds$id) # set creds
Sys.setenv(SPOTIFY_CLIENT_SECRET = creds$secret)

access_token <- get_spotify_access_token()

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


artists1 <- get_genre_artists(genre = "country")
artists_names <- artists1 %>% select(name)


#Trying to make a list of artists and their IDs
for (n in artists_names) {
  t <- search_artist(n)
  ids <- t$artists_id
  r <- t$artist_name
  
}
# I keep getting the error: "Error in vapply(elements, encode, character(1)) : 
#values must be length 1,
#but FUN(X[[1]]) result is length 20"
#Not exactly sure how to fix it, I've tried making the artists variable a data frame, list, and even a tibble.

#code to make those id's into a list of tracks 
for (i in ids) {
  songs <- get_artist_songs_df(i)
  lyrics_urls <- songs$song_lyrics_url %>% as.data.frame()
  
  
  
}


#example code to check stuff out 
MW <- search_artist("Morgan Wallen")
tracks <- get_artist_songs_df(artist_id = MW$artist_id)
lyrics_urls <- tracks$song_lyrics_url %>% as.data.frame()

for (l in lyrics_urls) {
  L <- geniusr::get_lyrics_url(l)
  
}

