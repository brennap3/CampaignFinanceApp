# Load Data


library(rvest)
library(dplyr)
library(sqldf)
library(rvest)
library(magrittr)
library(stringr)
library(tidyr)
library(lubridate)
library(ggplot2)

##pre-proc the data

return_dataframe_from_tablexpth <- function(os_page_url, htmlnode) {
  os_page_url_df <- os_page_url %>% html_nodes(xpath=htmlnode) %>%    html_table()  %>% as.data.frame() 
  return(os_page_url_df)
}

opensecrets_org_page_url <- read_html("http://www.opensecrets.org/pres16/outsidegroups.php?type=A")

##'//*[@id="topContrib"]'

scraped_us_finance_data<-return_dataframe_from_tablexpth(opensecrets_org_page_url,'//*[@id="topContrib"]')

colnames(scraped_us_finance_data)

#Assign color by Species

scraped_us_finance_data$party <- sapply(scraped_us_finance_data$Candidate, function(x) switch(as.character(x),
                                                      "Biden" = "Democrat",
                                                      "Bush" = "Republican",
                                                      "Carson" = "Republican",
                                                      "Christie" = "Republican",
                                                      "Clinton" = "Democrat",
                                                      "Cruz" = "Republican",
                                                      "Fiorina" = "Republican",
                                                      "Gilmore" = "Republican",
                                                      "Graham" = "Republican",
                                                      "Huckabee" = "Republican",
                                                      "Jindal" = "Republican",
                                                      "Johnson" = "Libertarian",
                                                      "Kasich" = "Republican",
                                                      "O'Malley" = "Democrat",
                                                      "Pataki" = "Republican",
                                                      "Paul" = "Republican",
                                                      "Perry" = "Republican",
                                                      "Rubio" = "Republican",
                                                      "Sanders" = "Democrat",
                                                      "Santorum" = "Republican",
                                                      "Stein" = "Green Party",
                                                      "Trump" = "Republican",
                                                      "Walker" = "Democrat",
                                                      "Webb" = "Democrat"
                                                      ))

##
## lets add a row for current only candidates
##


scraped_us_finance_data$Running <- sapply(scraped_us_finance_data$Candidate, function(x) switch(as.character(x),
                                                                                              "Clinton" = "Running",
                                                                                              "Trump" = "Running",
                                                                                              "Sanders" = "Running",
                                                                                              "Stein" = "Running",
                                                                                              "Johnson" = "Running",
                                                                                              "Not running"
                                                                                              ))
                                                                                              
##
#### lets clean our data
####
##

colnames(scraped_us_finance_data)

##ooh yuck lots of odd characters (a bit like dublinR) in those columns

scraped_us_finance_data$Total.Raised<-gsub(pattern = ",", replacement = "", x = scraped_us_finance_data$Total.Raised, ignore.case = T)

scraped_us_finance_data$Total.Raised<-gsub(pattern = "0N/A", replacement = "", x = scraped_us_finance_data$Total.Raised, ignore.case = T)

scraped_us_finance_data$Total.Raised<-gsub(pattern = "\\$", replacement = "", x = scraped_us_finance_data$Total.Raised, ignore.case = T)

##and cast it as a numeric

scraped_us_finance_data$Total.Raised <- as.numeric(scraped_us_finance_data$Total.Raised)

## give Total.Raised a better name

colnames(scraped_us_finance_data)[colnames(scraped_us_finance_data)=="Total.Raised"] <- "Total_Raised"

colnames(scraped_us_finance_data)
##replace with 0 NA's as we are only interested in known

## 501.4C tax-exempt nonprofit organization in the United States

## 527 A 527 group is created primarily to influence the selection, nomination, election, appointment or defeat of candidates to federal, state or local public office

scraped_us_finance_data[is.na(scraped_us_finance_data)] <- 0

Total_Raised_By_Candidate<-scraped_us_finance_data %>%
  group_by(Candidate) %>%
  summarise(sum_Total_Raised = sum(Total_Raised)) %>%
   as.data.frame()

Total_Raised_By_Candidate_Type<-scraped_us_finance_data %>%
  group_by(Candidate,Type,Running) %>%
  summarise(sum_Total_Raised = sum(Total_Raised)) %>%
  as.data.frame()

Total_Raised_By_Candidate_Type_Still_Running<-filter(scraped_us_finance_data,Running=="Running") %>% 
  group_by(Candidate,Type) %>%
  summarise(sum_Total_Raised = sum(Total_Raised)) %>%
  as.data.frame()


Total_Raised_By_Party_Type<-scraped_us_finance_data %>%
  group_by(party,Type) %>%
  summarise(sum_Total_Raised = sum(Total_Raised)) %>%
  as.data.frame()



