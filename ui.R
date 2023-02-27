library(shiny)
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("counties.rds")

fluidPage(
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

