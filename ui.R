library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("US wages Distribution"),
    h4("US wage data is shown through this simplified application. This simple app shows distribution of the wages of US population based on the year, marital status of the population, and job class"),
  h4("This app shows distribution of the wages as:"),
  h4("1. High level summary of the data"),
  h4("2. Histogram distribution of the data"),
   sidebarLayout(
    sidebarPanel(
      h3("Make a selection of Year, Job Class, and Marital Status"),
      sliderInput("year1", "Year of observation:",min=2003, max = 2009, value = 50,sep="",animate = TRUE),
      radioButtons("jobclass1","Job Class",choices=c("Industrial","Information"),selected="Industrial"),
             selectInput("maritl1", "Marital Status:",
                  c("Married" = "Married",
                    "Divorced" = "Divorced",
                    "Never Married" = "Never Married",
                    "Widowed"="Widowed",
                    "Separated"="Separated"))

          ),

    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("sum"),
       plotOutput("distPlot")
    )
  )
))