
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Relation between age and reported injuries based on NEISS data"),

  div(style="display: inline-block;vertical-align:top; width: 300px;",sliderInput("age",label = h4("Choose Age Range: "),
                                                                                  min = 0,
                                                                                  max = 100,
                                                                                  value = c(20,30))),
  div(style="display: inline-block;vertical-align:top; width: 100px;",HTML("<br>")),
  div(style="display: inline-block;vertical-align:top; width: 300px;",selectInput("race", label = h4("Race/ethnicity:"),
                                                                                  choices = levels(factor(injuries$race)), selected = "White")),
  div(style="display: inline-block;vertical-align:top; width: 100px;",HTML("<br>")),
  div(style="display: inline-block;vertical-align:top; width: 300px;",selectInput("fmv", label = h4("Fire Involvement:"),
                                                                                  choices = levels(factor(injuries$FMV)), selected = "No Fire or no flame/smoke spread")),
  

  
  fluidRow(
    column(6,
           plotOutput(outputId = "hist1")
           ),
    column(6,
           plotOutput(outputId = "hist2")
           )
  ),
  
  fluidRow(
    column(6,
           plotOutput(outputId= "hist3")
           ),
    column(6,
           plotOutput(outputId= "hist4")
    )
    )
))
