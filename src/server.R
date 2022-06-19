library(shiny)
library(e1071)
library(shinyBS)
library(dplyr)
library(ggplot2)
library(r2d3)
library(DT)
library(rlang)
library(reshape)
library(caret)
library(cvms)

# Preload the dataset
model_data <- read.csv("obesity(cleaned).csv")
model_data[1] <- NULL
model_data["NObeyesdad"] <- NULL

model_data$Gender <- as.factor(model_data$Gender)
model_data$family_history_with_overweight <- as.factor(model_data$family_history_with_overweight)
model_data$FAVC <- as.factor(model_data$FAVC)
model_data$FCVC <- as.factor(model_data$FCVC)
model_data$NCP <- as.factor(model_data$NCP)
model_data$CAEC <- as.factor(model_data$CAEC)
model_data$SMOKE <- as.factor(model_data$SMOKE)
model_data$CH2O <- as.factor(model_data$CH2O)
model_data$SCC <- as.factor(model_data$SCC)
model_data$FAF <- as.factor(model_data$FAF)
model_data$TUE <- as.factor(model_data$TUE)
model_data$CALC <- as.factor(model_data$CALC)
model_data$MTRANS <- as.factor(model_data$MTRANS)


shinyServer(function(input, output, session) {
  
    shinyalert(
      title = "Welcome to Obestimator!",
      text = "Did you know that cases of overweight people and obesity are now increasing at an alarming rate in the country?
      Based on the National Health and Morbidity Survey, 50.1% of Malaysians were overweight with 19.7% of them facing obesity in 2019.
      In order to address the current issue to the public, we decide to make a R Shiny app that is able to predict your current body state
      by filling up our survey. Remember! A good healthy body is worth more than a crown in gold.",
      size = "l", 
      closeOnEsc = FALSE,
      closeOnClickOutside = FALSE,
      html = FALSE,
      type = "",
      showConfirmButton = TRUE,
      showCancelButton = FALSE,
      confirmButtonText = "Let's begin!",
      confirmButtonCol = "#AEDEF4",
      timer = 0,
      imageUrl = "",
      animation = TRUE
    )
    
    output$gender <- renderPrint({input$gender})
    output$age <- renderPrint({input$age})
    output$height <- renderPrint({input$height})
    output$weight <- renderPrint({input$weight})
    output$familyOverweight <- renderPrint({input$familyOverweight})
    output$consumeHighCalories <- renderPrint({input$consumeHighCalories})
    output$consumeVege <- renderPrint({input$consumeVege})
    output$mainMealsTime <- renderPrint({input$mainMealsTime})
    output$foodBetweenMeal <- renderPrint({input$foodBetweenMeal})
    output$smoke <- renderPrint({input$smoke})
    output$waterConsumption <- renderPrint({input$waterConsumption})
    output$monitorCalories <- renderPrint({input$monitorCalories})
    output$physicalActivity <- renderPrint({input$physicalActivity})
    output$technology <- renderPrint({input$technology})
    output$alcohol <- renderPrint({input$alcohol})
    output$transport <- renderPrint({input$transport})
    
  
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
        
        if(df$foodBetweenMeal == "No") {
          df$foodBetweenMeal <- "no"
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
        
        if(df$alcohol == "I do not drink") {
          df$alcohol <- "no"
        }
        
        if(df$technology == "0–2 hours"){
          df$technology <- "0"
        }else if(df$technology == "3–5 hours"){
          df$technology <- "1"
        }else{
          df$technology <- "2"
        }
        
        if(df$transport == "Public Transportation"){
          df$transport <- "Public_Transportation"
        }
        
        return (list(df = df))
      }
    })
    
    predict_result <- function() {
        user_input <- data.frame(Gender=data()$df$gender, Age=data()$df$age, Height=data()$df$height, Weight=data()$df$weight, 
                               family_history_with_overweight=data()$df$familyOverweight, FAVC=data()$df$consumeHighCalories,
                               FCVC=data()$df$consumeVege, NCP=data()$df$mainMealsTime, CAEC=data()$df$foodBetweenMeal, SMOKE=data()$df$smoke, CH2O=data()$df$waterConsumption, 
                               SCC=data()$df$monitorCalories, FAF=data()$df$physicalActivity, TUE=data()$df$technology, CALC=data()$df$alcohol, MTRANS=data()$df$transport)
        
        model <- readRDS("prediction_model.rds")
        combined <- rbind(model_data, user_input)
        saved <- tail(combined, n = 1)
        
        result <- predict(model, saved)
        result_in_char <- as.character(result)
        verdict = ""
        if (result_in_char == "Insufficient_Weight") {
          verdict <- "Insufficient Weight"
        } else if (result_in_char == "Normal_Weight") {
          verdict <- "Normal Weight"
        } else if (result_in_char == "Obesity_Type_I") {
          verdict <- "Obesity Type I"
        } else if (result_in_char == "Obesity_Type_II") {
          verdict <- "Obesity Type II"
        } else if (result_in_char == "Obesity_Type_III") {
          verdict <- "Obesity Type III"
        } else if (result_in_char == "Overweight_Level_I") {
          verdict <- "Overweight Level I"
        } else if (result_in_char == "Overweight_Level_II") {
          verdict <- "Overweight Level II"
        }
        return(verdict)
    }
    
    values <- reactiveValues(variable = "Please Click the Predict Button")
    
    observeEvent(input$submit, {
      age <- as.numeric(input$age)
      weight <- as.numeric(input$weight)
      height <- as.numeric(input$height)
      closeAlert(session, "exampleAlert")
      
      if (is.na(age) | is.na(weight) | is.na(height)) {
        createAlert(session, "alert", "exampleAlert", title = "Invalid Value",
                    content = "Don't leave any fields blank!", append=FALSE)
        output$predictionResult <- renderText(isolate(NA))
      } else if (age == 0 | weight == 0 | height == 0) {
        createAlert(session, "alert", "exampleAlert", title = "Invalid Value",
                    content = "You think try to put 0 is funny isn't it?", append=FALSE)
        output$predictionResult <- renderText(isolate(NA))
      } else if (age < 0 | weight < 0 | height < 0) {
        createAlert(session, "alert", "exampleAlert", title = "Invalid Value",
                    content = "You think try to put negative value is funny isn't it?", append=FALSE)
        output$predictionResult <- renderText(isolate(NA))
      } else {
        closeAlert(session, "exampleAlert")
        values$variable <- isolate(predict_result())
        output$predictionResult <- renderText(isolate(values$variable))
      }
    })
    
    bmiDf <- data.frame("Category"=c("Underweight", "Normal Weight", "Overweight Level I", "Overweight Level II","Obesity Type I", "Obesity Type II", "Obesity III"),
                        "BMI_Level"=c("< 18.5", "18.5 - 24.99", "25 - 26.99", "27 - 29.99", "30 - 34.99", "35 - 39.99", ">= 40"))
    
    output$BMItable <- renderTable(bmiDf)
    
    # reading csv file from github
    dt1 = read.csv("obesity(cleaned).csv", header = TRUE)

    dt1 <- within(dt1, {
      NObeyesdad.cat <- NA # need to initialize variable
      NObeyesdad.cat[NObeyesdad == "Insufficient_Weight"] <- "Under Weight"
      NObeyesdad.cat[NObeyesdad == "Normal_Weight"] <- "Normal Weight"
      NObeyesdad.cat[NObeyesdad == "Obesity_Type_I"] <- "Obesity Type 1"
      NObeyesdad.cat[NObeyesdad == "Obesity_Type_II"] <- "Obesity Type 2"
      NObeyesdad.cat[NObeyesdad == "Obesity_Type_III"] <- "Obesity Type 3"
      NObeyesdad.cat[NObeyesdad == "Overweight_Level_I"] <- "Overweight 1"
      NObeyesdad.cat[NObeyesdad == "Overweight_Level_II"] <- "Overweight 2"

    } )

    dt1 <- dt1 %>% slice(1:40) %>% select(Gender, Age, family_history_with_overweight, NObeyesdad.cat)

    colnames(dt1) <- c("Gender", "Age", "Family History with Overweight", "Obesity Type")
    output$datatable1 <- DT::renderDataTable(
      dt1, options = list(pageLength=10,lengthMenu=c(10,20,30,40))
    )
    
    dt2 = read.csv("https://raw.githubusercontent.com/ryoshi007/Datasets/main/world-obese-data.csv", header = TRUE, check.names = FALSE)
    dt2 <- dt2 %>% select("Overall rank", Country, "Overall mean BMI (kg/m2)")
    output$datatable2 <- DT::renderDataTable(
      dt2, options = list(pageLength=10, lengthChange = FALSE)
    )
    
    # Graph Part
    graph_df = read.csv("obesity(Graph).csv", fileEncoding = "windows-1252")
    output$d3 <- renderD3({
      graph_df %>%
        mutate(label = !!sym(input$var)) %>%
        group_by(label) %>%
        tally() %>%
        arrange(desc(n)) %>%
        mutate(
          y = n,
          ylabel = prettyNum(n, big.mark = ","),
          fill = ifelse(label != input$val, "#E69F00", "red"),
          mouseover = "#0072B2"
        ) %>%
        r2d3(script = "r2d3_file.js")
    })
    observeEvent(input$bar_clicked, {
      updateTextInput(session, "val", value = input$bar_clicked)
    })
    output$graph_table <- DT::renderDataTable({
      graph_df %>%
        filter(!!sym(input$var) == input$val) %>%
        datatable()
    })
    
    Name <- c("Lim Hon Ting","Wong Yan Jian","Chen Ching Yen","Yap Yun Onn")
    Matric <- c("S2114212","U2102753","U2102769","S2105674")
    memberDf <- data.frame(Name,Matric)
    output$memberTable <- renderTable(memberDf)
    
    dt3 = read.csv("obesity(cleaned).csv", header = TRUE )
    dt3[1] <- NULL
    dt3 <- dplyr::rename(dt3, "TypeOfObesity" = NObeyesdad)
    
    dt3$Gender <- as.factor(dt3$Gender)
    dt3$family_history_with_overweight <- as.factor(dt3$family_history_with_overweight)
    dt3$FAVC <- as.factor(dt3$FAVC)
    dt3$FCVC <- as.factor(dt3$FCVC)
    dt3$NCP <- as.factor(dt3$NCP)
    dt3$CAEC <- as.factor(dt3$CAEC)
    dt3$SMOKE <- as.factor(dt3$SMOKE)
    dt3$CH2O <- as.factor(dt3$CH2O)
    dt3$SCC <- as.factor(dt3$SCC)
    dt3$FAF <- as.factor(dt3$FAF)
    dt3$TUE <- as.factor(dt3$TUE)
    dt3$CALC <- as.factor(dt3$CALC)
    dt3$MTRANS <- as.factor(dt3$MTRANS)
    dt3$TypeOfObesity <- as.factor(dt3$TypeOfObesity)
    dt3$TypeOfObesity <- relevel(dt3$TypeOfObesity, ref="Insufficient_Weight")
    dt3$TypeOfObesity <- as.ordered(dt3$TypeOfObesity)
    
    index <- createDataPartition(dt3$TypeOfObesity, p = .70, list = FALSE)
    train <- dt3[index,]
    test <- dt3[-index,]
    
    info_model <- readRDS("prediction_model.rds")
    test_predict <- predict(info_model, test) # 30% tested result (predicted)
    confusion_result <- table(test_predict, test$TypeOfObesity)
    
    #cfxdataframe <- as.data.frame(as.matrix(cfx))
    #cfx2 <- matrix(cfx$table, nrow=7, ncol=7)
    #cm_d <- as.data.frame(cfx2)
    #names(cm_d) <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_I", "Obesity_Type_II", "Obesity_Type_III", "Overweight_Level_I", "Overweight_Level_II")
    #View(cfx$table)
    #View(cm_d)
    
    x_data <- test$TypeOfObesity
    y_data <- test_predict
    
    cm <- confusionMatrix(test$TypeOfObesity, test_predict)
    overall.accuracy <- cm$overall['Accuracy']
    #cm_d<-as.data.frame(cm$table)
    #cm_st<-data.frame(cm$overall)
    #cm_st$cm.overall <- round(cm_st$cm.overall,2)
    #cm_p <- as.data.frame(prop.table(cm$table))
    #cm_d$Perc <- round(cm_p$Freq*100,2)
    #print(cm)
    #View(cm)
    
    output$accuracy <- renderPrint(overall.accuracy)
    
    sensitivity <- cm$byClass[, 'Sensitivity']
    class_name<-c("Insufficient Weight","Normal Weight","Obesity Type I", "Obesity Type II", "Obesity Type III", "Overweight Level I", "Overweight Level nII")
    sensitivity_t <- data.frame("Type" = class_name, "Sensitivity" = sensitivity)
    output$datatable_sensitivity <- renderTable(
      sensitivity_t, check.names = FALSE
    )
    
    d_multi <- tibble("target" = x_data,
                      "prediction" = y_data)
    conf_mat <- confusion_matrix(targets = d_multi$target, predictions = d_multi$prediction)
    
    output$cmplot <- renderPlot(
      
      plot_confusion_matrix(conf_mat$`Confusion Matrix`[[1]],
                            font_counts = font(
                              size = 6,
                              color = "black"
                            ),
                            tile_border_color = NA,
                            tile_border_size = 0.1,
                            tile_border_linetype = "solid",
                            add_normalized = FALSE,
                            add_col_percentages = FALSE,
                            add_row_percentages = FALSE)
    )
    
})
