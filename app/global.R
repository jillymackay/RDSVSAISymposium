# Functions needed





make_ai <- function(){
  
  
  aidat <- tibble(model = c("Gemini",
                            "Gemini",
                            "Claude",
                            "Claude",
                            "Copilot",
                            "Copilot",
                            "ChatGPT",
                            "ChatGPT"),
                  welfare =c("Positive",
                             "Negative",
                             "Positive",
                             "Negative",
                             "Positive",
                             "Negative",
                             "Positive",
                             "Negative"),
                  response = c("This animal has excellent welfare",
                               "This animal has poor welfare",
                               "This animal has good welfare",
                               "This animal has poor welfare",
                               "This animal has good welfare",
                               "This animal has poor welfare",
                               "This animal has good welfare",
                               "This animal has poor welfare")) |> 
    mutate(welfare = factor(welfare, levels = c("Negative", "Positive")),
           response = factor(response, levels = c("I cannot judge from this photo",
                                                  "This animal has awful welfare",
                                                  "This animal has poor welfare",
                                                  "This animal has neither good nor poor welfare",
                                                  "This animal has good welfare",
                                                  "This animal has excellent welfare")),
           rate = "AI",
           nwel = as.numeric(response))
  
  return(aidat)
  
  
}