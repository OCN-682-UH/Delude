#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    sliderInput(inputId = "num", #ID name for input
                label = "Choose a number", #labels for input
                value = 25, min = 1, max = 100 # values for the slider
                ), #always add a comma, its not like ggplot !!!!!
    textInput(inputId = "title",  #new ID is title
              label = "Write a title",
              value = "Histogram of Random Normal Values"), #starting title
    plotOutput("hist"), #creates a space for a plot called hist
    verbatimTextOutput("stats") #makes a space for stats below the plot
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  #use the identical name to the thing in the interface
    output$hist <- renderPlot({
      
      data <- reactive({
        tibble(x = rnorm(input$num))
      })
      
      ggplot(data(), #reactive objects are now functions
             aes(x = x)) +
        geom_histogram() +
        labs(title = input$title)
    })
    output$stats <- renderPrint({
      base::summary(data()) #calculate the summary stats based on the numbers
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
