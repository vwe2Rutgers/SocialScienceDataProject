library(shiny)
library(shinydashboard)
library(ggplot2)



ui <- fluidPage(
  
  # Application title
  titlePanel(title = "Comparing Reddit Comments Across Music Subreddits"),
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      selectInput("sel","Genre:",c("All","EDM","Rap","Country","Metal","Indie")),
      sliderInput("ncount","Count:",5,50,value = c(5),step=5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("Genre"),
      if(selectInput)
      plotOutput("rapsentiment_plot"),
      plotOutput("countrysentiment_plot"),
      plotOutput("EDMsentiment_plot")
      
      
      
      
    )
  )
)





server <- function(input,output){
  
  output$selectGenre <-{(
  renderText(input$sel)
  )}
  
  
  output$rapsentiment_plot <- renderPlot({
      ggplot(Rapdataset,aes(x=SentimentGI)) +
      ggtitle("Sentiment of Sample Rap Subreddit Data") +
      geom_histogram(binwidth = 0.05,color="#000000",alpha=0.5)
  })
  
  
  
  
}




shinyApp(ui, server)