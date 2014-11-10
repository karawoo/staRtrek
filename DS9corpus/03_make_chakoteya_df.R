# now we take the downloaded websites and make them dataframes

library(rvest)
library(dplyr)
library(tidyr)
library(magrittr)
library(stringr)

source("./DS9corpus/02_chakoteya_scraping.R")

sites <- list.files("DS9corpus/DS9_sites/", full.names = TRUE) %>% 
  lapply(html)

dfs <- lapply(sites, chakoteya_to_df)
episodes <- list.files("DS9corpus/DS9_sites/") %>%
  gsub(".html", "", .)

dfs2 <- Map(function(x, y) data.frame(episode = x, y), episodes, dfs)

corpus <- do.call(rbind, dfs2)

write.csv(corpus, file = "DS9corpus/ds9.csv", row.names = FALSE)
