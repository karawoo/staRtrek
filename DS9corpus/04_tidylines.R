## we need to clean up this data!

ds9 <- read.csv("DS9corpus/ds9.csv")

head(ds9)

ds9_no_notes <- ds9 %>%
  filter(!grepl("^\\(", scenecontent))

nrow(ds9_no_notes)

## separate the names from the lines

## convert names to sentence case

## check for strings of capitals in lines

## remove those pestky [scene] elements in the lines