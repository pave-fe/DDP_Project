library(ggplot2)
library(ggthemes)

data("diamonds")
carinput <- 1.5
cutinput <- "Very Good"
sel_diam <- subset(diamonds, cut == cutinput )

fit <- lm(price ~ carat + cut, diamonds)

#model1pred <- reactive({
#  caratinput <- input$carat
#  cutinput <- input$cut
  pred1 <- predict(fit, 
                   newdata = data.frame(data.frame(carat = carinput,  cut = cutinput)),
                   interval = "prediction", level = .95)

  # boxplot(pred1[,1:3])
# scatterplot of diamonds with selected cut and annotate chart with predictions
g <- ggplot(sel_diam, aes(x=carat, y=price)) +
  geom_point(aes(color=cut), alpha = 0.5) + 
  geom_vline(xintercept = carinput, color = "red", size = 1.5) +   
  geom_hline(yintercept = pred1[,1], color = "skyblue", size = 1.5) +
  annotate("pointrange", x = carinput, y = pred1[,1], ymin = pred1[,2], ymax = pred1[,3], 
             color = "green", size = 3, alpha = .6) +
  geom_text(aes(carinput, pred1[,2],  label = paste("$", round(pred1[,2], 2), "Min Estimate"))) +
  geom_text(aes(carinput, pred1[,1] -650,  label = paste("$", round(pred1[,1], 2), "Predicted"))) +
  geom_text(aes(carinput, pred1[,3] + 650,  label = paste("$", round(pred1[,3], 2), "Max Estimate"))) +
  theme_classic()
g
