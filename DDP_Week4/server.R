#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggthemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 
#   Model created using Linear Regression Model
    fit <- lm(price ~ carat + cut, diamonds)

# Prediction based on fit
    pred1 <- reactive({ 
      predict(fit, newdata = data.frame(data.frame(carat = input$carat,  cut = input$cut)),
              interval = "prediction", level = .95)
    })
    
# create the plot
    output$pricePlot <- renderPlot({
      caratinput <- input$carat
      cutinput <- input$cut
      # subset the data based on the inputs
      sel_diam <- subset(diamonds, cut == input$cut )
      
      # plot the diamond data with carat and price
      g <- ggplot(sel_diam, aes(x=carat, y=price)) +
        geom_point(aes(color=cut), alpha = 0.5) + 
        annotate("pointrange", x = caratinput, y = pred1()[,1], ymin = pred1()[,2], ymax = pred1()[,3], 
                 color = "green", size = 3, alpha = .6) +
        geom_text(aes(caratinput, pred1()[,2],  label = paste("$", round(pred1()[,2], 2), "Min Estimate"))) +
        geom_text(aes(caratinput, pred1()[,1] -650,  label = paste("$", round(pred1()[,1], 2), "Predicted"))) +
        geom_text(aes(caratinput, pred1()[,3] + 650,  label = paste("$", round(pred1()[,3], 2), "Max Estimate"))) +
        theme_classic()
      g    }, height = 400)   
       
    #model1pred <- reactive({
    #  caratinput <- input$carat
    #  cutinput <- input$cut
    pred1 <- reactive({ 
      predict(fit, newdata = data.frame(data.frame(carat = input$carat,  cut = input$cut)),
                     interval = "prediction", level = .95)
    })
    
output$pred11 <- renderText({
  round(pred1()[,1], 2)
})
    

})