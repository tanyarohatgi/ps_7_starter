library(tidyverse)
library(knitr)
library(janitor)
library(fs)

#READING IN THE DATA:

data <- read_csv("mt_2_results.csv") %>%
  clean_names()

download.file(url = "https://goo.gl/ZRCBda",
              destfile = "master.zip",
              quiet = TRUE,
              mode = "wb")

unzip("master.zip")

filenames <- dir_ls("2018-live-poll-results-master/data/")

x <- map_dfr(filenames, read_csv, .id = "source") 

x$source <- str_sub(x$source, 51, 57)



# WORKING WITH THE DATA:

x %>%
  mutate(new_source = str_sub(source, 1, 6)) %>% 
  filter(!str_detect(new_source, "sen")) %>%
  filter(!str_detect(new_source, "gov")) %>%
  separate(new_source, c("district", "wave"), sep = "-") %>%
  filter(wave == "3")
