library(shiny)
library(shinythemes)
library(shinyalert)
library(shinyBS)

shinyUI(fluidPage(theme = shinytheme("flatly"),
                  useShinyalert(force = TRUE),

    navbarPage(
      title = "Obestimator",
      id = "nav"),

    sidebarLayout(
        sidebarPanel(
            radioButtons("gender","1. Gender",c("Male","Female" )),
            numericInput("age","2. What is your age?","20"),
            numericInput("height","3. What is your height? (in m)","1.60"),
            numericInput("weight","4. What is your weight? (in kg)","60"),
            radioButtons("familyOverweight","5. Has a family member suffered or suffers from overweight?",c("Yes","No")),
            radioButtons("consumeHighCalories","6. Do you eat high calories food frequently?",c("Yes","No")),
            radioButtons("consumeVege","7. Do you usually eat vegetables in your meals?",c("Never", "Sometimes", "Always")),
            radioButtons("mainMealsTime","8. How many main meals do you have daily?",c("One","Two","Three","More than 3 meals")),
            radioButtons("foodBetweenMeal","9. Do you eat any food between meals?",c("No","Sometimes","Frequently","Always")),
            radioButtons("smoke","10. Do you smoke?",c("Yes","No")),
            radioButtons("waterConsumption","11. How much water do you drink daily?",c("Less than a litre","Between 1L and 2L","More than 2L")),
            radioButtons("monitorCalories","12. Do you monitor the calories you eat daily?",c("Yes","No")),
            radioButtons("physicalActivity","13. How often do you have physical activity?",c("I do not have","1 or 2 days","2 or 4 days","4 or 5 days")),
            radioButtons("technology","14. How much time do you use technological devices such as cell phone, videogames, television, computer, and others? ",c("0-2 hours","3-5 hours" ,"More than 5 hours")),
            radioButtons("alcohol","15. How often do you drink alcohol?",c("I do not drink" ,"Sometimes" ,"Frequently", "Always")),
            radioButtons("transport","16. Which transportation do you usually use?",c("Automobile" ,"Motorbike" ,"Bike" ,"Public Transportation" ,"Walking")),
            actionButton("submit","Predict")
        ),

        mainPanel(
          tabsetPanel(type="tabs",
                      #Detail Panel
                      tabPanel("Details",
                               h2(strong("Selection")),
                               br(),
                               h4(paste("Gender:")),
                               verbatimTextOutput("gender"),
                               h4(paste("Age:")),
                               verbatimTextOutput("age"),
                               h4(paste("Height:")),
                               verbatimTextOutput("height"),
                               h4(paste("Weight:")),
                               verbatimTextOutput("weight"),
                               h4(paste("Family history with overweight:")),
                               verbatimTextOutput("familyOverweight"),
                               h4(paste("Habit of consuming high calories food:")),
                               verbatimTextOutput("consumeHighCalories"),
                               h4(paste("Habit of eating vegetables:")),
                               verbatimTextOutput("consumeVege"),
                               h4(paste("Number of main meals per day:")),
                               verbatimTextOutput("mainMealsTime"),
                               h4(paste("Habit of eating food between meals")),
                               verbatimTextOutput("foodBetweenMeal"),
                               h4(paste("Smoking habit:")),
                               verbatimTextOutput("smoke"),
                               h4(paste("Habit of drinking water:")),
                               verbatimTextOutput("waterConsumption"),
                               h4(paste("Habit of monitoring calories:")),
                               verbatimTextOutput("monitorCalories"),
                               h4(paste("Habit of doing physical activities:")),
                               verbatimTextOutput("physicalActivity"),
                               h4(paste("Time spent on electroic devices:")),
                               verbatimTextOutput("technology"),
                               h4(paste("Habit of drinking alcohol:")),
                               verbatimTextOutput("alcohol"),
                               h4(paste("Transportation used:")),
                               verbatimTextOutput("transport"),
                               helpText("Click on Prediction tab to see the prediction result.")
                      ),
          
                      #Result Panel
                      tabPanel("Prediction",
                               h2(strong("Prediction Result")),
                               h3(verbatimTextOutput("predictionResult")),
                               bsAlert("alert"),
                               br(),
                               br(),
                               h2(strong("Tips and Advices")),
                               br(),
                               h3(paste("Underweight")),
                               br(),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Eat more frequently."))),
                                   p("When you're underweight, you may feel full faster. Eat five to six smaller meals during the day rather than two or three large meals.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Choose nutrient-rich foods."))),
                                   p("As part of an overall healthy diet, choose whole-grain breads, pastas and cereals; fruits and vegetables; dairy products; lean protein sources; and nuts and seeds.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Top it off."))),
                                   p("Add extras to your dishes for more calories — such as cheese in casseroles and scrambled eggs, and fat-free dried milk in soups and stews.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Exercise."))),
                                   p("Exercise, especially strength training, can help you gain weight by building up your muscles. Exercise may also stimulate your appetite.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Make every bite count."))),
                                   p("Snack on nuts, peanut butter, cheese, dried fruits and avocados. Have a bedtime snack, such as a peanut butter and jelly sandwich, or a wrap sandwich with avocado, sliced vegetables, and lean meat or cheese.")
                                 )
                               ),
                               br(),
                               h3(paste("Overweight")),
                               br(),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Healthy eating plan and regular physical activity."))),
                                   p("Following a healthy eating plan with fewer calories is often the first step in trying to treat overweight. People who are overweight should also start regular physical activity when they begin their healthy eating plan. Being active may help you use calories. Regular physical activity may help you stay at a healthy weight.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Changing your habits."))),
                                   p("Changing your eating and physical activity habits and lifestyle is difficult, but with a plan, effort, regular support, and patience, you may be able to lose weight and improve your health.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Weight-management programs."))),
                                   p("Some people benefit from a formal weight-management program. In a weight-management program, trained weight-management specialists will design a broad plan just for you and help you carry out your plan. Plans include a lower-calorie diet, increased physical activity, and ways to help you change your habits and stick with them. You may work with the specialists on-site (that is, face-to-face) in individual or group sessions.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Calorie-restricted diets."))),
                                   p("Your doctor may recommend a lower-calorie diet such as 1,200 to 1,500 calories a day for women and 1,500 to 1,800 calories a day for men. The calorie level depends on your body weight and physical activity level. A lower calorie diet with a variety of healthy foods will give you the nutrients you need to stay healthy.")
                                 )
                               ),
                               br(),
                               h3(paste("Obese")),
                               br(),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Eat varied, colourful, nutritionally dense foods."))),
                                   p("Eliminate trans fats from the diet, and minimize the intake of saturated fats, which has a strong link with the incidence of coronary heart disease.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Engage in regular physical activity and exercise."))),
                                   p("Regular exercise is vital for both physical and mental health. Increasing the frequency of physical activity in a disciplined and purposeful way is often crucial for successful weight loss.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Eliminate liquid calories."))),
                                   p("It is possible to consume hundreds of calories a day by drinking sugar-sweetened soda, tea, juice, or alcohol. These are known as “empty calories” because they provide extra energy content without offering any nutritional benefits.")
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4(strong("Measure servings and control portions."))),
                                   p("Eating too much of any food, even low-calorie vegetables, can result in weight gain. Therefore, people should avoid estimating a serving size or eating food directly from the packet. It is better to use measuring cups and serving size guides.")
                                 )
                               ),
                               
                      ),
                      
                      tabPanel("Dataset",
                               h3(strong(paste("An overview for People with Different Obesity level in The World"))),
                               dataTableOutput("datatable1"),
                               hr(),
                               h3(strong(paste("Ranking of Overweight by Country"))),
                               dataTableOutput("datatable2")
                               ),
                      
                      
                      tabPanel("Graph",
                               selectInput("var", "Variable",
                                           list("Gender","Family History With OverWeight"="Family_History_With_OverWeight",
                                                "Frequency of High Caloric Food Consumption"="Frequency_of_High_Caloric_Food_Consumption",
                                                "Vegetables Consumption"="Vegetables_Consumption","Number of Main Meals"="Number_of_Main_Meals",
                                                "Snack Between Meals"="Snack_Between_Meals","Smoke","Daily Water Intake"="Daily_Water_Intake",
                                                "Calories Monitoring"="Calories_Monitoring",
                                                "Physical Activity"="Physical_Activity","Technology Device Usage"="Technology_Device_Usage",
                                                "Alcohol Consumption"="Alcohol","Transportation",
                                                "Obesity Level Category"="Obesity_Level_Category"),
                                           selected = "Gender"),
                               d3Output("d3"),
                               DT::dataTableOutput("table"),
                               textInput("val", "Value", "Gender")
                               
                      ),
                      
                      
                      tabPanel("Information Center",
                               h2(strong("BMI Categories")),
                               br(),
                               h4(paste("Body Mass Index (BMI) is a simple index of weight-for-height 
                                  that is commonly used to classify underweight, overweight an obesity in adults.
                                  It is defined as a person's weight in kilograms divided by the square of his height in meters.")),
                               br(),
                               h4(paste("Here is the BMI scale")),
                               br(),
                               tableOutput("BMItable"),
                               br(),
                               h2(strong("Causes of Obesity and Overweight")),
                               br(),
                               h4(paste("The fundamental cause of obesity and overweight is an energy imbalance between calories consumed and calories expended. Globally, there has been:")),
                               br(),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Increase in intake of energy-dense food such as high in sugar and fat"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Increase in physical activity due to changing mode of transportation, increasing urbanization and workplace environment"))
                                 )
                               ),
                               br(),
                               h4(paste("Changes in dietary and physical activity patterns are often due to result of environmental and societal changes linked with
                                        development and lack of supportive policies in sectors like transport, urban planning, health, food processing, environment,
                                        agriculture and education.")),
                               br(),
                               h2(strong("Health Risks of Overweight and Obesity")),
                               br(),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Cardiovascular diseases like heart disease and stroke"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Diabetes"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Musculoskeletal disorders such as osteoarthritis"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Some cancers (including endometrial, breast, ovarian, prostate, liver, gallbladder, kidney and colon)"))
                                 )
                               ),
                               br(),
                               h4(paste("Researches have found that childhood obesity is associated with a higher chance of obesity, premature death and disability in adulthood.
                                        But in addition to increased future risks, obese children experience breathing difficulties, increased risk of fractures,
                                        hypertension, early markers of cardiovascular disease, insulin resistance and psychological effects.")),
                               br(),
                               h2(strong("Ways to Reduce Overweight and Obesity")),
                               br(),
                               h4(paste("At the individual level,")),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Limit energy intake from total fats and sugars"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Increase consumption of fruit and vegetables, as well as legumes, whole grains and nuts"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Engage in regular physical activity, either walking to the destination or spending less time with electronic
                                              devices and start doing exercises"))
                                 )
                               ),
                               br(),
                               h4(paste("At the parent level,")),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Prepare healthy and balance food to the children"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Spend more time with children to do outdoor activities"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Encourage children to eat less sugar and fats"))
                                 )
                               ),
                               br(),
                               h4(paste("At the school level,")),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Encourage students to participate exercises"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Increase the awareness among students about obesity"))
                                 )
                               ),
                               tags$div(
                                 tags$ul(
                                   tags$li(h4("Encourage canteeen to prepare more healthy food"))
                                 )
                               ),
                      )
                      
                      
                      
                      
                   )
                )
    )
))
