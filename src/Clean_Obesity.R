#This is the code that use to clean the data obtained from the website

df = read.csv("obesity.csv")
df2 = read.csv("obesity.csv")


library(dplyr)

iAge = as.integer(df$Age)
iFCVC = as.integer(df$FCVC)
iNCP = as.integer(df$NCP)
iCH2O = as.integer(df$CH2O)
iFAF = as.integer(df$FAF)



df4 = df%>%mutate(Age = as.character(replace(df$Age,1:2111,iAge[1:2111])))%>%
      mutate(Height = replace(df2$Height,1:2111,round(df2$Height,digits = 2)))%>%
      mutate(Weight = replace(df2$Weight,1:2111,round(df2$Weight,digits = 2)))%>%
      mutate(FCVC = as.character(replace(df2$FCVC,1:2111,iFCVC[1:2111])))%>%
      mutate(NCP = as.character(replace(df2$NCP,1:2111,iNCP[1:2111])))%>%
      mutate(CH2O = as.character(replace(df2$CH2O,1:2111,iCH2O[1:2111])))%>%
      mutate(FAF = as.character(replace(df2$FAF,1:2111,iFAF[1:2111])))%>%
      mutate(TUE = replace(df2$TUE,1:2111,round(df2$TUE,digits = 0)))

directory = getwd()
write.csv(df4, "obesity(cleaned).csv")

