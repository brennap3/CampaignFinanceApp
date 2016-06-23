library(shiny)

#Call library
library(ggplot2)
library(rvest)
library(dplyr)
library(sqldf)
library(rvest)
library(magrittr)
library(stringr)
library(tidyr)
library(lubridate)
library(ggplot2)


#initialization of server.R
shinyServer(function(input, output) {

  ##iris.sset <- reactive(subset(iris,Species %in% input$species))
  ##this is the operation and the reactive part
  Total_Raised_By_Candidate_Type.sset<-reactive(filter(Total_Raised_By_Candidate_Type, Candidate %in% input$Candidate & Type %in% input$Type))
  
  Total_Raised_By_Party_Type.sset<-reactive(filter(Total_Raised_By_Party_Type, Type %in% input$Type))
  
  #Plot generation
  ## this is an example of another operation
  
  output$custom.plot <- renderPlot({
    campaign_finance.ggplot <- ggplot(Total_Raised_By_Candidate_Type.sset(), aes(x = Candidate , y = sum_Total_Raised,fill=Type)) +
      geom_bar(stat='identity')+ggtitle("Totals raised by Candidate")+xlab("Candidate")+ylab("Amount in Dollars raised")+scale_y_continuous(label = scales::dollar)
    
    
    
    plot(campaign_finance.ggplot)
  })
  
  output$custom.plot2 <- renderPlot({
    campaign_finance.ggplot2 <- ggplot(Total_Raised_By_Party_Type.sset(), aes(x = party , y = sum_Total_Raised,fill=Type)) +
      geom_bar(stat='identity')+ggtitle("Totals raised by Party")+xlab("Candidate")+ylab("Amount in Dollars raised")+scale_y_continuous(label = scales::dollar)
    
    plot(campaign_finance.ggplot2)
  })
  
  output$table <- renderTable(Total_Raised_By_Candidate_Type.sset())
  
  output$plotly.plot <- renderPlotly({ plot_ly(df2, x = Candidate_Name, y = Total_Receipts, text = paste("Status: ", Running),mode = "markers", color = Debts_Owed_by_Committee, size = Cash_on_Hand)
     })
  
})