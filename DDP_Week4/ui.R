#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a scatter plot with estimated diamond price
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Select Diamond Features"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("carat",
                   "Select your size in Carats:",
                   min = .2,
                   max = 5.0,
                   value = 1.0),
       radioButtons("cut", 
                   "Select the Desired Cut:", 
                    c("Ideal" = "Ideal", "Premium" =  "Premium", 
                                   "Very Good" = "Very Good", "Good"= "Good",     
                                     "Fair" = "Fair")) 
                   
    ),
    
    # Show a plot and estimate of the diamond price
    mainPanel(
      h3("Plot of Selected Diamond Cut and Price Estimate"), 
      plotOutput("pricePlot"),
      h3("Predicted Diamond Price:"), 
      textOutput("pred11"),
      h4("Diamond price plotted above indicates the 95% probability range"),
      img(src="http://www.peakscientific.com/Media/diamond-004-96d09.jpg", 
          height=200, width = 200)
    )
  )
))
