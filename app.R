#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
setwd("D:\All JOB D\2024-D-job\Interview Prep 2024\Rshiny-remote-role\demo3")
library(shiny)
library(DT)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
        
     # shiny::selectInput(inputId="dd",label="choose data",choices=c("mtcars","iris")),
      shiny::selectInput(inputId = "dd", label = "Choose data", choices = c("mtcars", "iris")),
        ),
        # Show a plot of the generated distribution
        mainPanel(
          shiny::plotOutput("distPlot"),
          DT::DTOutput("table1")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
    select_data <-reactive({
      switch(input$dd,
             "mtcars"=mtcars,
             "iris" =iris)
    }
    
    )
    
    output$table1<-renderDT({
      select_data()
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
