
library(rcrossref)
library(tidyverse)
library(crminer)

# Remember to generate your Crossref auth token at https://apps.crossref.org/clickthrough/researchers
# Save your token to .Renviron e.g. usethis::edit_r_environ() 
# Recommended that this script is run from an academic institution in order to allow IP bypassing (this probably won't run from home)

geb_papers <- cr_works(filter = c(issn='1466-822X')) # Laura's original DOI - not sure where the 2X at the end has come from (returns >2000)

# What does this do? ST 29/11/18
n_pages <- ceiling(geb_papers$meta$total_results / geb_papers$meta$items_per_page)

geb_dois<- map_dfr(1:n_pages, function(x) {
  # get the start record for the page
  strt <- (x - 1)*20 + 1
  dois <- cr_works(filter = c(issn='1466-8238'), offset = strt)$data %>% 
    filter(type == "journal-article")
  return(dois)
})

# Pulls list of DOIs only
dois<-geb_dois$doi

# crm_links() takes all DOIs and returns those links with PDFs
# More PDFs *should* be available...many articles aren't returning PDF links. Speaking with Scott Chamberlain to resolve this.
links<-lapply(dois, crm_links, type="pdf")
pdf_links<-lapply(as_tdmurl(links))
pdfs<-crm_pdf(links)






####################################

geb_pdfs <- map(geb_dois$url, function(x) {
  # some code to download the pdfs
  # see http://tdmsupport.crossref.org/researchers/
})
