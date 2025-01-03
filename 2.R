library(shiny)
library(DT)

ui <- fluidPage(
  checkboxGroupInput("dd","chosee",choices=c("iris","mtcars")),
  DTOutput("table1")
)

server <- function(input, output, session) {
  
  output$table1<-renderDT({
    if ("iris" %in% input$dd)
    {
      datatable(head(iris))
    }
    else if ("mtcars" %in% input$dd)
    {
      datatable(head(mtcars))
    }
  })
}

shinyApp(ui, server)