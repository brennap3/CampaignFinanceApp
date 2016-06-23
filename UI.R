library(shiny)

# Starting line
shinyUI(fluidPage(
  
  # Application title
  titlePanel("US presidential campaign finance data 2016 with ggplot2"),
  
  # Sidebar
  sidebarLayout(  
  sidebarPanel(
      #Species selection
      checkboxGroupInput("Candidate","Select the candidate to plot, (This will affect the candidate plot only):",
                  c("Biden (DEM)"= "Biden", 
                    "Bush (REP)"="Bush", "Carson (REP)"="Carson",
                    "Christie (REP)"="Christie", "Clinton (DEM)"="Clinton",
                    "Cruz (REP)"="Cruz","Fiorina (REP)"="Fiorina",
                    "Gilmore (REP)"="Gilmore","Graham (REP)"="Graham",
                    "Huckabee (REP)"="Huckabee","Jindal (REP)"="Jindal",
                    "Johnson (LIB)"="Johnson", "Kasich (REP)" = "Kasich",
                    "O'Malley (DEM)"="O'Malley", "Pataki (REP)" = "Pataki",
                    "Paul (REP)"="Paul","Perry (REP)"="Perry",
                    "Rubio (REP)"="Rubio","Sanders (DEM)"="Sanders",
                    "Santorum (REP)"="Santorum","Stein (GRE)"="Stein",
                    "Trump (REP)"="Trump","Walker (REP)"="Walker",
                    "Webb (DEM)"="Webb"
                    ), 
                  selected=c("Biden", 
                             "Bush", "Carson",
                             "Christie", "Clinton",
                             "Cruz","Fiorina",
                             "Gilmore","Graham",
                             "Huckabee","Jindal",
                             "Johnson", "Kasich",
                             "O'Malley", "Pataki",
                             "Paul","Perry",
                             "Rubio","Sanders",
                             "Santorum","Stein",
                             "Trump","Walker",
                             "Webb")),
      checkboxGroupInput("Type","Select the Campaign Finance Type, (This will affect the candidate both plot) :",
                         c(
                           "Super-PAC"="SuperPAC",
                           "501c4-NP"="501c4",
                           "Campaign Raised"="Campaign",
                           "Leadership-PAC"="Leadership PAC",
                           "Carey Comittee"="Carey",
                           "PAC-NP"="PAC",
                           "527-NP"="527"
                         ), 
                         selected=c(
                           "SuperPAC",       
                           "501c4",          
                           "Campaign",       
                           "Leadership PAC", 
                           "Carey",          
                           "PAC",
                           "527"
                         ))
      
      ),
      
    
  #The plot created in server.R is displayed
    mainPanel(
      tabsetPanel("PLots and Data",tabPanel("Instructions & Documentation","Instructions for the Camapign Finance app: 
                                            The app was constructed with data taken from (http://www.opensecrets.org/pres16).
                                            By checking the tickboxs an analyst can include/exclude a candidate.
                                            It is possible to view analysis by candidate and by party (using selected candidates) in Plots tab.
                                            Also it is possible to look at the detailed table information in long form in Summary tab.
                                            The application was built with shiny and uses dplyr and ggplot to analyze the data and rvest to scrape the data.
                                            The checkbox inputs on the server affect the reactive output which then based on these inputs (Candidate or Donation type) is then aggregated accordingly using dplyr (the server calculations). 
                                            Then the results are plotted using ggplot and the plot returned to the UI as a server output. 
                                            The github repo for this file is available here:
                                            https://github.com/brennap3/CampaignFinanceApp
                                            "),tabPanel("Plots",fluidRow(column(12,plotOutput("custom.plot")),
                                                column(8,plotOutput("custom.plot2")))
                                                      ),tabPanel("Summary",tableOutput('table')),
                                                        tabPanel("Plotly bubble-plot of Campaign Finance",tags$head(tags$style(type = "text/css", "#plotly\2e plot {height:100vh !important;}")),plotlyOutput("plotly.plot"))
                                                        
      )
      
    )
  
  )
))
