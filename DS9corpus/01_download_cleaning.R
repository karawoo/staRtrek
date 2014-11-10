## download transcripts from http://www.chakoteya.net

library(rvest)
library(dplyr)
library(staRtrek)
library(tidyr)
library(magrittr)

# takes a show name, returns a function of episode number
# StarTrek = TOS
# NextGen  = TNG
# Voyager  = VOY
# DS9
get_script_url <- function(show){
  force(show)
  function(epnum){
    sprintf("http://www.chakoteya.net/%s/%s.htm", show, epnum)
  }
}

ds9_list <- episodes("DS9")

DS9_episodes <- do.call(rbind, ds9_list) %>%
  separate(Prodno., c("season", "episode"), remove = FALSE) %>%
  mutate(episode = ifelse(episode == 721, 401, episode)) # for some reason, "Emissary" has a different number!

## get the websites
sites <- DS9_episodes %>% 
  extract2("episode") %>%
  lapply(get_script_url("DS9")) %>%
  lapply(html)

names(sites) <- DS9_episodes %>% 
  extract2("episode")

save(sites, file = "./DS9corpus/01_DS9_websites.Rdata")
