library(shiny)
library(shinythemes)
library(shinyalert)
library(reshape)
library(ggplot2)
library(dplyr)

#Cleaning dataset for Graph Part, obesity(Graph).csv

df = read.csv("obesity(cleaned).csv",header=TRUE)
df <- within(df, {   
  NObeyesdad.cat <- NA # need to initialize variable
  NObeyesdad.cat[NObeyesdad == "Insufficient_Weight"] <- "Under Weight"
  NObeyesdad.cat[NObeyesdad == "Normal_Weight"] <- "Normal Weight"
  NObeyesdad.cat[NObeyesdad == "Obesity_Type_I"] <- "Obesity Type 1"
  NObeyesdad.cat[NObeyesdad == "Obesity_Type_II"] <- "Obesity Type 2"
  NObeyesdad.cat[NObeyesdad == "Obesity_Type_III"] <- "Obesity Type 3"
  NObeyesdad.cat[NObeyesdad == "Overweight_Level_I"] <- "Overweight 1"
  NObeyesdad.cat[NObeyesdad == "Overweight_Level_II"] <- "Overweight 2"
  
} )

df <- within(df, {   
  family_history_with_overweight.cat <- NA # need to initialize variable
  family_history_with_overweight.cat[family_history_with_overweight == "yes"] <- "Yes"
  family_history_with_overweight.cat[family_history_with_overweight == "no"] <- "No"

} )

df <- within(df, {   
  FAVC.cat <- NA # need to initialize variable
  FAVC.cat[FAVC == "yes"] <- "Yes"
  FAVC.cat[FAVC == "no"] <- "No"
  
} )

df <- within(df, {   
  FCVC.cat <- NA # need to initialize variable
  FCVC.cat[FCVC == "1"] <- "Never"
  FCVC.cat[FCVC == "2"] <- "Sometimes"
  FCVC.cat[FCVC == "3"] <- "Always"
} )

df <- within(df, {   
  NCP.cat <- NA # need to initialize variable
  NCP.cat[NCP == "1"] <- "One"
  NCP.cat[NCP == "2"] <- "Two"
  NCP.cat[NCP == "3"] <- "Three"
  NCP.cat[NCP == "4"] <- "More than three"
} )

df <- within(df, {   
  SMOKE.cat <- NA # need to initialize variable
  SMOKE.cat[SMOKE == "yes"] <- "Yes"
  SMOKE.cat[SMOKE == "no"] <- "No"
  
} )

df <- within(df, {   
  CH2O.cat <- NA # need to initialize variable
  CH2O.cat[CH2O == "1"] <- "Less than a liter"
  CH2O.cat[CH2O == "2"] <- "Between 1 and 2 L"
  CH2O.cat[CH2O == "3"] <- "More than 2 L"
} )

df <- within(df, {   
  SCC.cat <- NA # need to initialize variable
  SCC.cat[SCC == "yes"] <- "Yes"
  SCC.cat[SCC == "no"] <- "No"
  
} )

df <- within(df, {   
  TUE.cat <- NA # need to initialize variable
  TUE.cat[TUE == "0"] <- "0–2 hours"
  TUE.cat[TUE == "1"] <- "3–5 hours"
  TUE.cat[TUE == "2"] <- "More than 5 hours"
} )

df <- within(df, {   
  CALC.cat <- NA # need to initialize variable
  CALC.cat[CALC == "no"] <- "No"
  CALC.cat[CALC == "Sometimes"] <- "Sometimes"
  CALC.cat[CALC == "Always"] <- "Always"
  CALC.cat[CALC == "Frequently"] <- "Frequently"
  
} )

df <- within(df, {   
  MTRANS.cat <- NA # need to initialize variable
  MTRANS.cat[MTRANS == "Public_Transportation"] <- "Public Transportation"
  MTRANS.cat[MTRANS == "Automobile"] <- "Automobile"
  MTRANS.cat[MTRANS == "Motorbike"] <- "Motorbike"
  MTRANS.cat[MTRANS == "Bike"] <- "Bike"
  MTRANS.cat[MTRANS == "Walking"] <- "Walking"
  
  
} )



df <- within(df, {   
  FAF.cat <- NA # need to initialize variable
  FAF.cat[FAF == "0"] <- "Inactive"
  FAF.cat[FAF == "1"] <- "1 or 2 days"
  FAF.cat[FAF == "2"] <- "2 or 4 days"
  FAF.cat[FAF == "3"] <- "4 or 5 days"
} )

df_renamed = data.frame(df$X,df$Gender,df$Age,df$Height,df$Weight,df$family_history_with_overweight.cat,
                        df$FAVC.cat,df$FCVC.cat,df$NCP.cat,df$CAEC,df$SMOKE.cat,df$CH2O.cat,df$SCC.cat,
                        df$FAF.cat,df$TUE.cat,df$CALC.cat,df$MTRANS.cat,df$NObeyesdad.cat)

colnames(df_renamed) = c("Index","Gender","Age","Height","Weight","Family_History_With_OverWeight",
                         "Frequency_of_High_Caloric_Food_Consumption","Vegetables_Consumption","Number_of_Main_Meals",
                         "Snack_Between_Meals","Smoke","Daily_Water_Intake","Calories_Monitoring",
                         "Physical_Activity","Technology_Device_Usage","Alcohol","Transportation",
                         "Obesity_Level_Category")
write.csv(df_renamed, "obesity(Graph).csv")




