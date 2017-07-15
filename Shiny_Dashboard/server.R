
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyServer(function(input, output) {
  selected<-reactive({
    injuries %>% filter(age>=input$age[1]&age<input$age[2], race == input$race,FMV == input$fmv)
  })
  
  output$hist1<-renderPlot({
   left_join(selected() %>% group_by(product) %>%
               summarize(total_product=sum(weight)) %>%
               top_n(15,total_product)%>% arrange(desc(total_product)),
             selected() %>% group_by(product,sex)%>%
               summarize(total_by_sex=sum(weight)),by=c("product"="product")) %>%
      mutate(product = factor(product, levels = rev(unique(product)))) %>%
      ggplot(aes(x = product, y = total_by_sex,group=sex,fill=sex))+geom_bar(stat = "identity")+
      labs(y="Number of Injuries", x =NULL , title="Top 15 Product")+
      coord_flip()
      
  })
  
  output$hist2<-renderPlot({
    left_join(selected()%>% group_by(BodyPart) %>%
                summarize(total_body=sum(weight)) %>% 
                top_n(15,total_body)%>% arrange(desc(total_body)),
              selected()%>% group_by(BodyPart,sex) %>%
                summarize(total_by_sex=sum(weight)),by=c("BodyPart"="BodyPart"))%>%
      mutate(BodyPart = factor(BodyPart, levels = unique(BodyPart))) %>% 
      ggplot(aes(x=BodyPart,y=total_by_sex,fill=sex))+geom_bar(position="dodge",stat = "identity")+
      labs(x=NULL, y = "Number of Injuries", title="Top 15 Body Part")
    
    
  })
  
  output$hist3<-renderPlot({
    left_join(selected()%>% group_by(Diagnosis) %>%
                summarize(total_Dia=sum(weight)) %>% 
                top_n(15,total_Dia)%>% arrange(desc(total_Dia)),
              selected()%>% group_by(Diagnosis,sex) %>%
                summarize(total_by_sex=sum(weight)),by=c("Diagnosis"="Diagnosis"))%>%
      mutate(Diagnosis = factor(Diagnosis, levels = rev(unique(Diagnosis)))) %>% 
      ggplot(aes(x=Diagnosis,y=total_by_sex))+geom_point(aes(shape = factor(sex)),size = 3)+
      labs(x=NULL, y = "Number of Injuries", title="Top 15 Diagnosis")+
      coord_flip()
  })
  
  output$hist4<-renderPlot({
    selected()%>% filter(location!=0) %>% group_by(Location,sex) %>%
      summarize(total_loc = sum(weight)) %>%
      arrange(desc(total_loc)) %>%
      
      treemap(index=c('sex',"Location"),fontsize.labels=c(17,12),  fontcolor.labels=c("white","black"),
              align.labels=list(
                
                c("left", "bottom"),
                c("center", "center")
              ),  overlap.labels=0.5,vSize="total_loc",type='index',title='Location Distribution')
  })
  



})
