
library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("How does a split point affect how well we can predict MPG from horsepower"),
  
  sidebarLayout(
    
    sidebarPanel(
      sliderInput('sliderquants', 
                  "At what quantile do you want to split the data?", 
                  0.1, 0.9, value=0.5),
      h3("Background"),
      p("Depending on your background, and if you're grad school, your supervisor's background", 
      "(and current interests), you may have minimal or maximal expopsure to regressions with fancy terms.",
       "For example, polynomials or splines. I, for example, am really far behind in the stats game.",
      "I've been trying really hard to catch up, but to be frank, like most academic disciplines,",
      "the barrier to entry is not insubstantial."),
      
      p("But enough about me and my inane chatter."),
      
      p("Given that there are so many different ways to analyse data, even with just a 3 term linear regression",
        "I thought it'd be interesting to look at, and display what happens to statistics like R2 and information criteria (AIC)",
        "when we change where the knots occur in a curvilinear (black line) and linear spline (red line). I also used the",
        "basic linear model (in blue) as a baseline"),
      
      p("For this project used built-in funcitons for the curvilinear spline (formula=y~bs(x)) and the linear model (blue).",
        "In contrast, I used the lspline package for the linear spline. I also used the built-in quantile function to",
        "split the data at various points ranging from the 10th percentile up to the 90th to see what happens to the",
        "performance of the splines when the data are split at different points."),
      
      p("This analysis uses the mtcars dataset included with R.",
        "I thought it made more sense to predict fuel efficiency from horsepower rather than the other way around."),
      
     
      h3("Instructions"),
      p("All you need to do is move the slider and watch what happens to the lines on the plot and to the colour-coded",
      "R2 and AIC values. The blue line is static and won't change - it's only there for reference, but watch how the stats",
      "improve (R2 going higher and AIC going lower) as the split point in the data shifts from left to right or vice",
      "versa. You can both click and drag the slider or you can use the left and right arrows for much finer control. Enjoy")), 
    
    mainPanel(plotOutput("plot1"))))
              
              


