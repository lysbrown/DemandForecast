#### REMOTE SERVER NOTEBOOK

library(forecast)
library(tidyverse)
library(lubridate)
library(StanHeaders)
install.packages(prophet)
library(prophet)

store.train <- vroom::vroom("/Users//LysLysenko/Desktop/Kaggle/DemandForecasting/train.csv")
store.test <- vroom::vroom("/Users/LysLysenko/Desktop/Kaggle/DemandForecasting/test.csv")
store <- bind_rows(store.train,store.test, .id = "id")

preds <- data.frame(id = integer(), sales = numeric())
pb <- txtProgressBar(min = 0, max = 500, style = 3)
ind <- 0
# FOR LOOP
for(i in 1:10){
  for(j in 1:50){
    ind = ind + 1
    setTxtProgressBar(pb, ind)
    train <- store.train %>%  
      filter(store == i & item == j) %>% 
      mutate(ds = date, y = sqrt(sales)) %>%
      select(c(ds,y))
    ids <- store.test %>%
      filter(store == i & item == j) %>%
      pull(id)
    test <- store.test %>% 
      filter(item == j & store == i) %>% 
      mutate(ds = date) %>%
      select(ds)
    model <- prophet(daily.seasonality = FALSE)
    model <- fit.prophet(model,train)
    forecast <- predict(model,test)
    new_preds <- data.frame(id = ids, sales = (forecast$yhat)^2)
    preds <- bind_rows(preds,new_preds) %>%
      arrange(id)
  }
}
close(pb)
write_csv(preds,"submission.csv")
