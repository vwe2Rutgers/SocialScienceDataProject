library(spotifyr)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)
library(genius)
library(geniusr)


Spotifycreds <- read_json("SpotifyCreds.json") 

Sys.setenv(SPOTIFY_CLIENT_ID = Spotifycreds$id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = Spotifycreds$secret)

Spotifyaccess_token <- get_spotify_access_token()




Geniuscreds <- read_json("GeniusCreds.json") 

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
genius_lyrics(artist = "Margaret Glaspy", song = "Memory Street")


get_song(song_id = 90479)






