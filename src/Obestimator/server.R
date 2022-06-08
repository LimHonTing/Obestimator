library(shiny)

shinyServer(function(input, output) {
    data<- reactive({
      if(input$submit >0){
        df <- data.frame(gender = input$gender,age = input$age,height= input$height,
                         weight = input$weight, familyOverweight = input$familyOverweight,
                         consumeHighCalories = input$consumeHighCalories, consumeVege = input$consumeVege,
                         mainMealsTime = input$mainMealsTime, foodBetweenMeal = input$foodBetweenMeal,
                         smoke = input$smoke, waterConsumption= input$waterConsumption, 
                         monitorCalories = input$monitorCalories, physicalActivity = input$physicalActivity,
                         technology= input$technology, alcohol = input$alcohol, transport = input$transport)
        
        if(df$familyOverweight == "Yes"){
          df$familyOverweight <- "yes"
        }else{
          df$familyOverweight <- "no"
        }
        
        if(df$consumeHighCalories == "Yes"){
          df$consumeHighCalories <- "yes"
        }else{
          df$consumeHighCalories <- "no"
        }
        
        if(df$consumeVege == "Never"){
          df$consumeVege <- "1"
        }else if(df$consumeVege == "Sometimes"){
          df$consumeVege <- "2"
        }else{
          df$consumeVege <- "3"
        }
        
        if(df$mainMealsTime == "One"){
          df$mainMealsTime <- "1"
        }else if(df$mainMealsTime == "Two"){
          df$mainMealsTime <- "2"
        }else if(df$mainMealsTime == "Three"){
          df$mainMealsTime <- "3"
        }else{
          df$mainMealsTime <- "4"
        }
        
        if(df$smoke == "Yes"){
          df$smoke <- "yes"
        }else{
          df$smoke <- "no"
        }
        
        if(df$waterConsumption == "Less than 1 liter"){
          df$waterConsumption <- "1"
        }else if(df$waterConsumption == "Between 1L and 2L"){
          df$waterConsumption <- "2"
        }else{
          df$waterConsumption <- "3"
        }
        
        if(df$monitorCalories == "Yes"){
          df$monitorCalories <- "yes"
        }else{
          df$monitorCalories <- "no"
        }
        
        if(df$physicalActivity == "I do not have"){
          df$physicalActivity <- "0"
        }else if(df$physicalActivity == "1 or 2 days"){
          df$physicalActivity <- "1"
        }else if(df$physicalActivity == "2 or 4 days"){
          df$physicalActivity <- "2"
        }else{
          df$physicalActivity <- "3"
        }
        
        if(df$technology == "0–2 hours"){
          df$technology <- "0"
        }else if(df$technology == "3–5 hours"){
          df$technology <- "1"
        }else{
          df$technology <- "2"
        }
        
        return (list(df = df))
      }
    })
    
    output$result <- renderText({
      if(is.null(data())){return()}
      print(data()$df$consumeVege)
    })
})
