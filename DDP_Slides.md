DDP_Slides
========================================================
author: Mike Hulin
date: 24 June 2018
autosize: true

Diamond Price Estimator
========================================================

This application estimates diamond prices for prospective buyers

- Data Set Described
- Plot of Diamonds
- Pricing Algorithm

Link to Shiny Application:  https://pavefe.shinyapps.io/DDP_Week4/
Link to github:  https://github.com/pave-fe/DDP_Project 

Data Set Described
========================================================
The Diamond Data set contain the prices and other attributes of almost 54,000 diamonds.

This application estimates price based on two of the attributes:

Carat - weight of the diamond (0.2-5.01)

Cut - quality of the cut (Fair, Good, Very Good, Premium, Ideal)

Diamond Data Plot
========================================================

![plot of chunk unnamed-chunk-1](DDP_Slides-figure/unnamed-chunk-1-1.png)


Pricing Algorithm
========================================================
A linear regression model is created based on the selected attributes.

```r
#   Model created using Linear Regression Model
    fit <- lm(price ~ carat + cut, diamonds)

# Prediction based on created model
    pred1 <- reactive({ 
      predict(fit, newdata = data.frame(data.frame(carat = input$carat,  cut = input$cut)),
              interval = "prediction", level = .95)
```



