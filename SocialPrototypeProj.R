library(spotifyr)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(geniusr)
library(dplyr)
library(tidytext)


creds <- read_json("creds.json") 

Sys.setenv(SPOTIFY_CLIENT_ID = creds$id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = creds$secret)

access_token <- get_spotify_access_token()

















