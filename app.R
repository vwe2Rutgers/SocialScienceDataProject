library(rsconnect)
library(shiny)
library(ggplot2)
library(tidyverse)
library(jsonlite)
library(rmarkdown)
library(httr)
library(readr)
library(RedditExtractoR)
library(tidyverse)
library(jsonlite)
library(lubridate)
library(dplyr)
library(knitr)
library(stringr)
library(tidytext)
library(word2vec)
library(stm)
library(ggplot2)
library(viridis)
library(parallel)
library(reshape2)
library(magrittr)
library(SentimentAnalysis)



ui <- fluidPage(
  
  # Application title
  titlePanel(title = "Comparing Reddit Comments Across Music Subreddits"),
  
  sidebarLayout(
    
    # Sidebar with a slider input and selectInput
    sidebarPanel(
      selectInput("sel","Genre:",choices=c("All","EDM","Rap","Indie","jazz")),
      sliderInput("ncount","Top Word Count:",5,100,value = c(5),step=5)
    ),
    
    # Show a plot 
    mainPanel(
      textOutput("Genre"),
      plotOutput("sentiment_plot"),
      plotOutput("comment_plot"),
      plotOutput("topComments")
      
      
  
      
      
    )
  )
)





server <- function(input,output){
  
  output$selectGenre <-{(
  renderText(input$sel)
  )}
  
  
  
  
  output$sentiment_plot <- renderPlot({
    
    if(input$sel=="All"){
      ggplot(all_genres,aes(x=SentimentGI)) +
        ggtitle("Sentiment All Subreddit Data") +
        geom_histogram(binwidth = 0.05,color="red",fill="red",alpha=0.5,position = "identity")
      
      
      #ggplot(Countrydataset,aes(x=SentimentGI)) +
       # geom_histogram(binwidth = 0.05,color="blue",fill="blue",alpha=0.5)
      
      
      
    }
    else{
      all_genresplot <- all_genres %>%filter(...1==input$sel)
      
       ggplot(all_genresplot,aes(x=SentimentGI)) +
       ggtitle("Sentiment Subreddit Data") +
       geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)
      
    }
  })
  
  
  output$comment_plot <- renderPlot({
    
    if(input$sel=="All"){
      
      plotSentimentResponse(all_genresComments$SentimentGI,all_genresComments$score...6,ylab = "Comment Score", smoothing = "lm")
    }
    
    else{
      #sentiment comments
      all_genresCommentsFilter <- all_genresComments %>% filter(SubReddit...2==input$sel)
      plotSentimentResponse(all_genresCommentsFilter$SentimentGI,all_genresCommentsFilter$score...6,ylab = "Comment Score", smoothing = "lm")
      
    }
    
    
    
  })
  
  
  
  
  output$topComments <- renderPlot({
    
    if(input$sel=="All"){
      
      all_TopComments %>% count(word, sort = TRUE) %>%
        slice(1:input$ncount) %>%
        mutate(word = reorder(word, n)) %>%
        ggplot(aes(n, word)) + geom_col() +
        labs(y = NULL, x='Term frequency', title=paste("Frequent terms in collected corpus"))
      
      
    }
    
    
    else{
      
      all_TopCommentsFilter <- all_TopComments %>%filter(SubReddit==input$sel)
      
      all_TopCommentsFilter %>% count(word, sort = TRUE) %>%
        slice(1:input$ncount) %>%
        mutate(word = reorder(word, n)) %>%
        ggplot(aes(n, word)) + geom_col() +
        labs(y = NULL, x='Term frequency', title=paste("Frequent terms in subreddit corpus"))
    
      
    }
    
     })
  
  
}




shinyApp(ui, server)