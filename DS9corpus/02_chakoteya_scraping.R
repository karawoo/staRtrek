# extracting scripts into a data.frame

ep <- site %>%
  html_nodes(css = "td font") %>%
  html_text

names(ep) <- NULL

ep_no_rn <- str_replace_all(ep, fixed("\r\n"), replacement = " ")

tail(ep_no_rn)
head(ep_no_rn)
names(ep_no_rn)

## check for different "scenes". This is possible, because the transcriber has 
## indicated each scene with a line that begins with a "[", e.g. "[Promenade]"
## square braces are used elsewhere but never to lead the line. Sometimes there is leading space, sometimes not

scenes <- ep_no_rn %>% 
  str_detect("^ *\\[") %>%
  which


## now, using the locations of these "scene" labels, we extract the positions of
## all the blocks of text which are in between them, or which come after the
## last one (ie the content of the scene)
eplen <- length(ep_no_rn)
scenelist <- list()
scenes2 <- c(scenes, eplen)

for(i in seq_along(scenes)){
  content <- seq(scenes2[i] + 1, scenes2[i + 1] - 1)
  scenelist[i] <- list(content)
}

## extract each scene's content
contentlist <- lapply(scenelist, function(x) ep_no_rn[x])

## Each chunk of text contains several lines. We need to go along and divide 
## these. how about by every space followed by at least two capital letters? 
## Even better; the script seems to only contain double spaces at the end of a
## sentence!

## Now we combine all the items in a single scene. We are left with a vector of scene content
scene_content <- lapply(contentlist, function(x) str_split(x, pattern = "  ")) %>%
  lapply(function(x) unlist(x))

## Get the scene names
scene_names <- ep_no_rn[scenes] %>%
  str_replace(" *\\[", replacement = "") %>%
  str_replace("\\] *", replacement = "")

## finally,we combine the names with the scenes:
line_df <- Map(function(x, y) data.frame(scenename = x, scenecontent = y), scene_names, scene_content)

ep1 <- do.call(rbind, line_df) %>% 
  cbind(ep_number = epnum)
epname <- paste0("ep", epnum, ".csv")
write.csv(ep1, epname, row.names = FALSE)
