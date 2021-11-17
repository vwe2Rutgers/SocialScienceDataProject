---
  Jesskomar Velarde Gargot 
prototpe code for spotify API
---
library(spotifyr)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(ggplot2)
library(rvest)
library(stringr)
library(magrittr)
library(reshape2)

creds <- read_json("creds.json") # read creds

Sys.setenv(SPOTIFY_CLIENT_ID = creds$id) # set creds
Sys.setenv(SPOTIFY_CLIENT_SECRET = creds$secret)

access_token <- get_spotify_access_token()

artists <- get_genre_artists(genre = "country")
artists <- artists$name
for (a in artists) {
  
}