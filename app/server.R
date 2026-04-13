# Server file

library(shiny)
library(tidyverse)
library(see)
library(nord)



shinyServer(function(input, output, session){
  
  # ---------------------- Create Reactive Dataset
  
  
  dat <- make_ai()
  
  
  
  
  # ------------------ Return plots
  
  
  output$p_comparison <- renderPlot({
    
    dat |> 
      mutate(xlab = str_c(welfare, rate, sep = " ")) |> 
      ggplot(aes(x = xlab)) +
      geom_point(aes(y = nwel, colour = rate), position = position_jitter(width = .13), size = 0.5, alpha = 0.6) +
      see::geom_violinhalf(aes(y = nwel, alpha= 0.3, fill = rate), linetype = "dashed", position = position_nudge(x = .2)) +
      geom_boxplot(aes(y = nwel, alpha = 0.3, colour = rate), position = position_nudge(x = -.1), width = 0.1, outlier.shape = NA) +
      scale_fill_manual(values = NineteenEightyR::electronic_night(n = 6)) +
      scale_colour_manual(values = NineteenEightyR::electronic_night(n = 6)) +
      theme_classic() +
      scale_y_continuous(breaks = seq (1, 6, 1), limits = c(1, 6), labels = c("Cannot Judge",
                                                                              "Awful",
                                                                              "Poor",
                                                                              "Neither",
                                                                              "Good",
                                                                              "Excellent"))+
      labs(x = "Image and Rater", y = "How woyld you rate this animal's welfare?",
           caption = "Animal Welfare Experts and genAI Ratings of AI Generated Media") +
      theme(legend.position = "none") +
      coord_flip() 
    
    
  })
  
  
})