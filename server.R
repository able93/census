library(shiny)
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("counties.rds")

 function(input, output) {
  output$selected_demo <- renderText({
    paste("You have selected",input$demo)
  })  
  
  output$min_max <- renderText({
    paste("You have selected a range between", input$slider[1], "and", input$slider[2])
  })
  
  output$map <- renderPlot({
    data <- switch (input$demo,
                    "Percent White" = counties$white,
                    "Percent Black" = counties$black,
                    "Percent Hispanic" = counties$hispanic,
                    "Percent Asian" = counties$asian)
    percent_map(data, "orange", input$demo, input$slider[1], input$slider[2])
  })
  
}

