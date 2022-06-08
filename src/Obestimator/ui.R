library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("gender","1. Gender",c("Male","Female" )),
            numericInput("age","2. What is your age?","20"),
            numericInput("height","3. What is your height?(in m)","1.60"),
            numericInput("weight","4. What is your weight?(in kg)","60"),
            radioButtons("familyOverweight","5. Has a family member suffered or suffers from overweight?",c("Yes","No")),
            radioButtons("consumeHighCalories","6. Do you eat high calories food frequently?",c("Yes","No")),
            radioButtons("consumeVege","7. Do you usually eat vegetables in your meals?",c("Never", "Sometimes", "Always")),
            radioButtons("mainMealsTime","8. How many main meals do you have daily?",c("Between 1 and 2","Three","More than 3")),
            radioButtons("foodBetweenMeal","9. Do you eat any food between meals?",c("No","Sometimes","Frequently","Always")),
            radioButtons("smoke","10. Do you smoke?",c("Yes","No")),
            radioButtons("waterConsumption","11. How much water do you drink daily?",c("Less than a litre","Between 1L and 2L","More than 2L")),
            radioButtons("monitorCalories","12. Do you monitor the calories you eat daily?",c("Yes","No")),
            radioButtons("physicalActivity","13. How often do you have physical activity?",c("I do not have","1 or 2 days","2 or 4 days","4 or 5 days")),
            radioButtons("technology","14. How much time do you use technological devices such as cell phone, videogames, television, computer, and others? ",c("0-2 hours","3-5 hours" ,"More than 5 hours")),
            radioButtons("alcohol","15. How often do you drink alcohol?",c("I do not drink" ,"Sometimes" ,"Frequently", "Always")),
            radioButtons("transport","16. Which transportation do you usually use?",c("Automobile" ,"Motorbike" ,"Bike" ,"Public Transportation" ,"Walking")),
            actionButton("submit","Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          uiOutput("result")
        )
    )
))
