# R Studio API Code
library(rstudioapi)
setwd(dirname(getActiveDocumentContext()$path))

# Data Import
library(stringi)
citations <- stri_read_lines("../data/citations.txt")
citations_txt <- citations[!stri_isempty(citations)]
length(citations) - length(citations_txt)

#Data Cleaning
library(tidyverse)
library(stringr)

sample(citations_txt,10)
citations_tbl <- tibble(line = 1:length(citations_txt), cite = citations_txt) %>% 
  mutate(cite = str_replace(cite, pattern = "\'|\"", replacement = "" )) %>% 
  mutate(year = str_extract(cite, pattern = "[1|2][0-9]{3}")) %>% 
  mutate(page_start = str_extract(str_extract(cite, pattern = "[1-9]{1,}[-|?][0-9]{1,}"), pattern = "[0-9]{1,}[^-?]")) %>% 
  mutate(perf_ref = str_detect(cite, regex("performance", ignore_case = TRUE))) %>% 
  mutate(title = str_remove(str_extract(cite, pattern = "(\\.[^\\.]*\\.[^\\.]*\\.[^\\.]*$)"), pattern = "^[[:punct:]]{1,}")) %>% 
  mutate(first_author = str_extract(citations_tbl$cite, pattern = ".+?([A-Z]{1,2}[\\. | ,]{0,1}\\s{0,1}){1,2}"))