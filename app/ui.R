library(shiny)
library(DT)


shinyUI(
  navbarPage(title = "R(D)SVS AI Symposium, 2026",
             id = "navbar",
             theme = shinythemes::shinytheme("yeti"),
             
             tabPanel(title = "AI Models versus Experts",
                      sidebarPanel(tags$h2("What did you rate the positive cow?"),
                                   
                                   numericInput(inputId = "wel_1ex",
                                                label = "How many people said excellent?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "wel_2gd",
                                                label = "How many people said good?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "wel_3ne",
                                                label = "How many people said neither?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "wel_4po",
                                                label = "How many people said poor?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "wel_5aw",
                                                label = "How many people said awfu?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "wel_6cj",
                                                label = "How many people said cannot judge?",
                                                value = 0,
                                                min = 0, 
                                                max = 300)
                                   ),
                      
                      mainPanel(tags$h2("How do you compare?"),
                                
                                fluidPage(column(width = 6,
                                                 plotOutput(outputId = "p_comparison"))))
                      
                      ))
)