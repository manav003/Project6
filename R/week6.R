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
  mutate(title = str_extract(cite, pattern = "\\s([A-z]{1,}\\s{1}){1,}([A-z]{1,}\\.{1}){1}")) #%>% 
  mutate(first_author = str_extract(citations_tbl$cite, pattern = ".+?([A-Z]{1,2}[\\. | ,]{0,1}\\s{0,1}){1,2}"))  #"([A-Z]{1,2}[\\. | ,]){1,2}"))

#for title, get everything before [[:punct:]]{0,}\s([A-Z]{1,2}[\. | ,]{0,1}){1,2}
  
  #.*([A-z]{1,}\s{1}){1,}([A-z]{1,}\.{1}){1}
  
#Line 21:Create a new variable called title that contains the citation title.
  #(\.[^\.]*\.[^\.]*\.[^\.]*$)
  
#Line 22-as many needed:Create a new variable called first_author that contains the last name and any initials of the first author of each citation.  Be careful with the number of initials and match regardless of any extra or missing spaces. Remember to capture hyphenated names.Ensure you check your work frequently as you engineer asolutionto capture at least 99% of first names correctly.You may want to build code to randomly draw a few names for spot checks.  

#str_detect("This is a sentence." , "\\.")   < need to escape the backslash!!!  
# could also used , fixed(".") but then you can't mix and match inside fixed, as inside fixed is all literals
  fruit <- c("apple", "bAnAnA", "pear", "pinapple")
  str_detect(fruit, regex("a", ignore_case = FALSE))
  
             