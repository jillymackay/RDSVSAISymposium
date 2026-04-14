library(shiny)
library(DT)
library(bslib)


shinyUI(
  navbarPage(title = "R(D)SVS AI Symposium, 2026",
             id = "navbar",
            
             
             tabPanel(title = "AI Models versus Experts",
                      sidebarPanel(tags$h2("What did you rate the positive cow?"),
                                  
                                   numericInput(inputId = "pwel_1ex",
                                                label = "How many people said excellent?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "pwel_2gd",
                                                label = "How many people said good?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "pwel_3ne",
                                                label = "How many people said neither?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "pwel_4po",
                                                label = "How many people said poor?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "pwel_5aw",
                                                label = "How many people said awful?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "pwel_6cj",
                                                label = "How many people said cannot judge?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   
                                   tags$h2("What did you rate the negative cow?"),
                                   
                                   numericInput(inputId = "nwel_1ex",
                                                label = "How many people said excellent?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "nwel_2gd",
                                                label = "How many people said good?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "nwel_3ne",
                                                label = "How many people said neither?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "nwel_4po",
                                                label = "How many people said poor?",
                                                value = 0,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "nwel_5aw",
                                                label = "How many people said awful?",
                                                value = 1,
                                                min = 0, 
                                                max = 300),
                                   numericInput(inputId = "nwel_6cj",
                                                label = "How many people said cannot judge?",
                                                value = 1,
                                                min = 0, 
                                                max = 300)
                                   ),
                      imageOutput("logo", inline = TRUE),
                      
                      mainPanel(tags$h2("What did you think of the cow's welfare?"),
                                tags$body("While I input some numbers, you can think about whether this counts
                                          as a welfare assessment, or I'm simply asking your perception of welfare. 
                                          It's honestly been playing on my mind. "),
                               
                      
                                
                                ),
                      
                                
                      
                      ),
             tabPanel(title = "Let's see!",
                      
                      
                      
                      
                      mainPanel(imageOutput("logo1", inline = TRUE),
                                tags$h2("You vs the AI",
                                        
                                        
                                        fluidPage(plotOutput(outputId = "p_comparison"))))
                      
                      
             
             )
)

)
