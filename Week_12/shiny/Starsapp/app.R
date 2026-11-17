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

stars = read_csv("data/stars.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
      selectInput(inputId = "min_stars",
                label = "Show sites with at least this many sea stars:",
                choices = c(1, 5, 10, 20),
                selected = 5),
      plotOutput("star_map")
      
)


# Define server logic required to draw a histogram
server <- function(input, output) {
        
  kept_sites <- reactive({
      stars |>
      #selectInput returns choices as STRINGS, so convert back to numeric!
      filter(star_no >= as.numeric(input$min_stars))
  })
  
  output$star_map <- renderPlot({
    ggplot(kept_sites(), aes(x = long, y = lat)) +
      geom_point(aes(size = star_no), color = "red") + # points sized by count
      labs(size = "Sea stars counted")
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
