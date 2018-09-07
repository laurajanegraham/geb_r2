library(rcrossref)
library(tidyverse)
geb_papers <- cr_works(filter = c(issn='1466-822X'))
n_pages <- ceiling(geb_papers$meta$total_results / geb_papers$meta$items_per_page)

geb_dois <- map_dfr(1:n_pages, function(x) {
  # get the start record for the page
  strt <- (x - 1)*20 + 1
  dois <- cr_works(filter = c(issn='1466-822X'), offset = strt)$data %>% 
    filter(type == "journal-article")
  return(dois)
})

geb_pdfs <- map(geb_dois$url, function(x) {
  # some code to download the pdfs
  # see http://tdmsupport.crossref.org/researchers/
})
