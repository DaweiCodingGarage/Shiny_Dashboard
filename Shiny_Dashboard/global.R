library(ggplot2)
library(dplyr)
library(scales)
library(treemap)


Neiss_data<-read.csv("G:\\interviews\\BI\\BI_Developer_HW\\NEISS2014.csv",sep= ',',header=TRUE)
load("G:\\interviews\\BI\\BI_Developer_HW\\products.rda")
body_part<-read.csv("G:\\interviews\\BI\\BI_Developer_HW\\BodyParts.csv",sep= ',',header=TRUE)
diagCode<-read.csv("G:\\interviews\\BI\\BI_Developer_HW\\DiagnosisCodes.csv",sep= ',',header=TRUE)
locale<-read.csv("G:\\interviews\\BI\\BI_Developer_HW\\Location .csv",sep= ',',header=TRUE)
fire<-read.csv("G:\\interviews\\BI\\BI_Developer_HW\\FMV .csv",sep= ',',header=TRUE)


pro<-left_join(Neiss_data,products,by=c("prod1"="code"),copy=TRUE)%>% rename(product = title)
body<-left_join(pro,body_part,by=c("body_part"="Code"),copy=TRUE)
dia<-left_join(body,diagCode,by=c("diag"="Code"),copy=TRUE)
fire<-left_join(dia,fire,by=c("fmv"="Code"),copy=TRUE)
injuries<-left_join(fire,locale,by=c("location"="Code"),copy=TRUE)

for(i in 1:dim(injuries)[1]){
  if(injuries[i,"age"]>=200){
    injuries[i,"age"] =(injuries[i,"age"]-200)/12.0
  }
}


#product_fre<-injuries %>% group_by(title) %>%
#                    summarize(Pro_Counts=n()) %>%
#                     top_n(20,Pro_Counts)%>% arrange(desc(Pro_Counts))

  
#body_fre<-injuries %>% group_by(BodyPart) %>%
#                  summarize(Body_Counts=n()) %>%
#                  top_n(20,Body_Counts) %>% arrange(desc(Body_Counts))

#ggplot(product_fre,aes(x=title,y=Pro_Counts))+geom_bar(stat = "identity")+
#  coord_flip() +ggtitle(("Top 20 products"))

#ggplot(body_fre,aes(x=BodyPart,y=Body_Counts))+geom_bar(stat = "identity")+
#  coord_flip() +ggtitle(("Top 20 Body_Part"))
