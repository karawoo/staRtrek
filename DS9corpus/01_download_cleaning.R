## download transcripts from http://www.chakoteya.net

library(rvest)
library(dplyr)

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

site <- get_script_url("NextGen")(252) %>%
  html

