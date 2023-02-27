
library(shiny)
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("counties.rds")

ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel("Create dempographic maps with information from the 2010 US Census.",

             selectInput("demo",
                         label = "Choose a variable to display",
                         choices = list("Percent White",
                         "Percent Black",
                         "Percent Hispanic",
                         "Percent Asian"), selected = "Percent White"),

             sliderInput("slider",
                         label = "Range of interest:",
                         min = 0, max = 100, value = c(0,100))

    ),
    mainPanel(
      textOutput("min_max"),
      textOutput("selected_demo"),
      plotOutput("map")
      )
  )
)


server <- function(input, output) {
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

shinyApp(ui, server)