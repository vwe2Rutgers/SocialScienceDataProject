library(spotifyr)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)


Spotifycreds <- read_json("SpotifyCreds.json") 

Sys.setenv(SPOTIFY_CLIENT_ID = Spotifycreds$id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = Spotifycreds$secret)

Spotifyaccess_token <- get_spotify_access_token()




Geniuscreds <- read_json("GeniusCreds.json") 

genius_token(force = TRUE)


get_song(song_id = 90479)






