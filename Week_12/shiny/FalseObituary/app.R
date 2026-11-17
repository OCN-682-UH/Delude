#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(DT) #needed to render data tables in Shiny
library(tidyverse)
library(tidytuesdayR)

# Loading TidyTuesday Data
#Code comes from the TidyTuesday Github
tuesdata <- tidytuesdayR::tt_load(2026, week = 45)

fiction_citations <- tuesdata$fiction_citations
fiction_deaths <- tuesdata$fiction_deaths
fiction_rankings <- tuesdata$fiction_rankings


# Define UI for application that selects a fictional character from a dropdown menu
ui <- fluidPage(

    # Application title
    titlePanel("Fictional Obituary (Massive Spoilers)"),

    # Sidebar with a slider input for number of bins 
    selectizeInput(
                   inputId = "fiction_name",
                   label = "Obituary Search by Work",
                   choices = c("", unique(fiction_deaths$work))),
                              #^ added in a blank string at first so you don't totally spoil yourself
    DT::DTOutput("obit_table"),

        # Plot the years a franchise "kills"
        mainPanel(
           plotOutput("death_year")
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #clean the fictional deaths df
  fiction_deaths_clean <- fiction_deaths |>
    select(work, victim, killer, year, confidence, undone, verdict)
  
#using the DT library to render the data frame
    output$obit_table <- renderDT({
        req(input$fiction_name)
      
       fiction_deaths_clean |>
       filter(work == input$fiction_name) #you need to alter the df in order for the dynamic table to work
    }, 
      options = list(lengthChange = FALSE))
    
#using ggplot to render a self-highlighting histogram  
    output$death_year <- renderPlot({
      req(input$fiction_name)
      
      ggplot(fiction_deaths_clean, aes(x = year, fill = (work == input$fiction_name))) +
  #Plot is hella cluttered when it's by single years, and every 10 simplifies it too much, 5 is an ok middle ground
        geom_histogram(binwidth = 5, color = "black") +
        scale_fill_manual(values = c(
                                      "TRUE" = "red",
                                      "FALSE" = "gray"),
                          guide = "none") +
  #Using code to make the ranges! Turns a year into a 5-year
        scale_x_continuous(breaks = seq(
          floor(min(fiction_deaths_clean$year, na.rm = TRUE) / 5) * 5,
          ceiling(max(fiction_deaths_clean$year, na.rm = TRUE) / 5) * 5,
          by = 10
        )) +
        theme_minimal() +
        labs(
          title = paste(input$fiction_name,"'s Murderousness Highlighted"),
          x = "Year",
          y = "Count"
        )
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
