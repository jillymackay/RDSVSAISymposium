# Server file

library(shiny)
library(tidyverse)
library(see)
library(nord)



shinyServer(function(input, output, session){
  
  # ---------------------- Create Reactive Dataset
  
  
  dat <- make_ai()
  
  pcrowd <- reactive({
    c(input$pwel_1ex, input$pwel_2gd, input$pwel_3ne, input$pwel_4po, input$pwel_5aw, input$pwel_6cj)
    })
  
  ncrowd <- reactive({
    c(input$nwel_1ex, input$nwel_2gd, input$nwel_3ne, input$nwel_4po, input$nwel_5aw, input$nwel_6cj)
  })
  
  
  d_pexp <- reactive ({
    
    tibble(rep(levs, times = pcrowd))  |> 
    rename(response = `rep(levs, times = pcrowd)`) |> 
    mutate(response = factor(response, levels = c("I cannot judge from this photo",
                                                  "This animal has awful welfare",
                                                  "This animal has poor welfare",
                                                  "This animal has neither good nor poor welfare",
                                                  "This animal has good welfare",
                                                  "This animal has excellent welfare")),
           rate = "Experts",
           nwel = as.numeric(response),
           welfare = "Positive")
    
  })
  
    d_exp <- reactive ({
    
    d_pexp <- tibble(rep(levs, times = pcrowd))  |> 
    rename(response = `rep(levs, times = pcrowd)`) |> 
    mutate(response = factor(response, levels = c("I cannot judge from this photo",
                                                  "This animal has awful welfare",
                                                  "This animal has poor welfare",
                                                  "This animal has neither good nor poor welfare",
                                                  "This animal has good welfare",
                                                  "This animal has excellent welfare")),
           rate = "Experts",
           nwel = as.numeric(response),
           welfare = "Positive")
    
    d_nexp <- tibble(rep(levs, times = ncrowd)) |> 
      rename(response = `rep(levs, times = ncrowd)`) |> 
      mutate(response = factor(response, levels = c("I cannot judge from this photo",
                                                    "This animal has awful welfare",
                                                    "This animal has poor welfare",
                                                    "This animal has neither good nor poor welfare",
                                                    "This animal has good welfare",
                                                    "This animal has excellent welfare")),
             rate = "Experts",
             nwel = as.numeric(response),
             welfare = "Negative")
    
    d_exp <- rbind(d_nexp, d_pexp) |> 
      mutate(model = "Human")
    
    return(d_exp)
    
  })
    
    alldat <- rbind(dat,d_exp)
  
  
  # ------------------ Return plots
  
  
  output$p_test <- renderPlot({
    
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
      labs(x = "Image and Rater", y = "How would you rate this animal's welfare?",
           caption = "Animal Welfare Experts and genAI Ratings of AI Generated Media") +
      theme(legend.position = "none") +
      coord_flip() 
    
    
  })
  
  
  
  output$p_comparison <- renderPlot({
    
    alldat |> 
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
      labs(x = "Image and Rater", y = "How would you rate this animal's welfare?",
           caption = "Animal Welfare Experts and genAI Ratings of AI Generated Media") +
      theme(legend.position = "none") +
      coord_flip() 
    
    
  })
  
})