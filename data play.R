
# test


library(tidyverse)




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




aidat |> 
  mutate(xlab = str_c(welfare, rate, sep = " ")) |> 
  ggplot(aes(x = xlab)) +
  geom_point(aes(y = nwel, colour = welfare), position = position_jitter(width = .13), size = 2, alpha = 0.6) +
  see::geom_violinhalf(aes(y = nwel, alpha= 0.3, fill = welfare), linetype = "dashed", position = position_nudge(x = .2)) +
  geom_boxplot(aes(y = nwel, alpha = 0.3, colour = welfare), position = position_nudge(x = -.1), width = 0.1, outlier.shape = NA) +
  scale_fill_manual(values = NineteenEightyR::electronic_night(n = 2)) +
  scale_colour_manual(values = NineteenEightyR::electronic_night(n = 2)) +
  theme_classic() +
  scale_y_continuous(breaks = seq (1, 6, 1), limits = c(1, 6), labels = c("Cannot Judge",
                                                                           "Awful",
                                                                           "Poor",
                                                                           "Neither",
                                                                           "Good",
                                                                           "Excellent"))+
  labs(x = "Image and Rater", y = "How would you rate this animal's welfare?",
       caption = "genAI Ratings of AI Generated Media (Cow)") +
  theme(legend.position = "none") +
  coord_flip() 






pwel_1ex <- 4
pwel_2gd <- 3
pwel_3ne <- 2
pwel_4po <- 3
pwel_5aw <- 1
pwel_6cj <- 3


nwel_1ex <- 0
nwel_2gd <- 1
nwel_3ne <- 1
nwel_4po <- 4
nwel_5aw <- 5
nwel_6cj <- 2



levs <- c("I cannot judge from this photo",
           "This animal has awful welfare",
           "This animal has poor welfare",
           "This animal has neither good nor poor welfare",
           "This animal has good welfare",
           "This animal has excellent welfare")
pcrowd <- c(pwel_1ex, pwel_2gd, pwel_3ne,
            pwel_4po,
            pwel_5aw, 
            pwel_6cj)

ncrowd <- c(nwel_1ex, nwel_2gd, nwel_3ne,
            nwel_4po,
            nwel_5aw, 
            nwel_6cj)

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


alldat <- rbind(aidat,d_exp)



alldat |> 
  mutate(xlab = str_c(welfare, rate, sep = " ")) |> 
  ggplot(aes(x = xlab)) +
  geom_point(aes(y = nwel, colour = welfare), position = position_jitter(width = .13), size = 2, alpha = 0.6) +
  see::geom_violinhalf(aes(y = nwel, alpha= 0.3, fill = welfare), linetype = "dashed", position = position_nudge(x = .2)) +
  geom_boxplot(aes(y = nwel, alpha = 0.3, colour = welfare), position = position_nudge(x = -.1), width = 0.1, outlier.shape = NA) +
  scale_fill_manual(values = NineteenEightyR::electronic_night(n = 4)) +
  scale_colour_manual(values = NineteenEightyR::electronic_night(n = 4)) +
  theme_classic() +
  scale_y_continuous(breaks = seq (1, 6, 1), limits = c(1, 6), labels = c("Cannot Judge",
                                                                          "Awful",
                                                                          "Poor",
                                                                          "Neither",
                                                                          "Good",
                                                                          "Excellent"))+
  labs(x = "Image and Rater", y = "How would you rate this animal's welfare?",
       caption = "genAI Ratings of AI Generated Media (Cow)") +
  theme(legend.position = "none") +
  coord_flip() 




make_crowd <- function(levs, times) {
  
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
  
  
}
