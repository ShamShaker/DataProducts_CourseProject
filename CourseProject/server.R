#

library(shiny)
library(tidyverse)
library(ggsci)
library(splines)
library(ggformula)
library(lspline)
library(gridExtra)
library(ggpmisc)

shinyServer(function(input, output, session){
  
  state <- reactiveValues()
  
  observe({
    state$x <- input$sliderquants
    state$y <- quantile(mtcars$hp, state$x) 
  })
  
  output$plot1<-renderPlot({
  
  ggplot(data=mtcars, aes(x=hp, y=mpg))+
      geom_point()+
      xlab("Horse power")+
      ylab('Miles per gallon')+
      ggtitle("How changing model parameters changes the (expected) predictive performance")+
      
      # # linear model line
      
          geom_smooth(method='lm', se=FALSE, color='blue', linetype='dotted')+
      
          stat_poly_eq(method='lm', formula=y~x, use_label("R2"), color='blue', label.x = 0.1, rr.digits=4) +
          
          stat_poly_eq(method='lm', formula=y~x, use_label("AIC"), color='blue', label.x = 0.1, label.y = 0.9, rr.digits=4) +
      
      ## linear spline model
      
          geom_smooth(method="lm", formula= y~lspline(x, knots=state$y), se=FALSE, color='red', lwd=2) +
      
          stat_poly_eq(method='lm', formula=y~lspline(x, knots=state$y), use_label("R2"), color='red', label.x = 0.25, rr.digits=4) +
        
          stat_poly_eq(method='lm', formula=y~lspline(x, knots=state$y), use_label("AIC"), color='red', label.x = 0.25, label.y = 0.9, rr.digits=4) +
      
      
      ## curvilinear spline
      
            geom_smooth(method="lm", formula=y~bs(x, knots=state$y), se=FALSE, color='black', lwd=2) +
          
            stat_poly_eq(method='lm', formula=y~bs(x, knots=state$y), use_label("R2"), color='black', label.x = 0.4, rr.digits=4) +
          
            stat_poly_eq(method='lm', formula=y~bs(x, knots=state$y), use_label("AIC"), color='black', label.x = 0.4, label.y = 0.9, rr.digits=4) +
      
      
      theme_bw()
  
     
      })
      
})






