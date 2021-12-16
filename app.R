library(rsconnect)
library(shiny)
library(ggplot2)



ui <- fluidPage(
  
  # Application title
  titlePanel(title = "Comparing Reddit Comments Across Music Subreddits"),
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      selectInput("sel","Genre:",choices=c("All","EDM","Rap","Country","Metal","Indie")),
      sliderInput("ncount","Count:",5,50,value = c(5),step=5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("Genre"),
      plotOutput("sentiment_plot"),
      
      
  
      
      
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
      all_genresplot <- all_genres %>%filter(value==input$sel)
      
       ggplot(all_genresplot,aes(x=SentimentGI)) +
       ggtitle("Sentiment Subreddit Data") +
       geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)
      
    }
  })
  
  
  
  
}




shinyApp(ui, server)