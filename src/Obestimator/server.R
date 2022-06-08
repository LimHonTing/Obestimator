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
        
        
        if(df$consumeVege == "Never"){
          df$consumeVege <- 0
        }else if(df$consumeVege == "Sometimes"){
          df$consumeVege <- 1
        }else{
          df$consumeVege <- 2
        }
        
        return (list(df = df))
      }
    })
    
    output$result <- renderText({
      if(is.null(data())){return()}
      print(data()$df$consumeVege)
    })
})
