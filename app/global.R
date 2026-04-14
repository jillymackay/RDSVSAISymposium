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



make_crowd <- function(ptimes, ntimes) {
  
  levs <- c("I cannot judge from this photo",
            "This animal has awful welfare",
            "This animal has poor welfare",
            "This animal has neither good nor poor welfare",
            "This animal has good welfare",
            "This animal has excellent welfare")
  
  d_pexp <- tibble(rep(levs, ptimes))  |> 
    rename(response = `rep(levs, ptimes)`) |> 
    mutate(response = factor(response, levels = c("I cannot judge from this photo",
                                                  "This animal has awful welfare",
                                                  "This animal has poor welfare",
                                                  "This animal has neither good nor poor welfare",
                                                  "This animal has good welfare",
                                                  "This animal has excellent welfare")),
           rate = "Experts",
           nwel = as.numeric(response),
           welfare = "Positive")
  
  d_nexp <- tibble(rep(levs, ntimes)) |> 
    rename(response = `rep(levs, ntimes)`) |> 
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
  
  
}
