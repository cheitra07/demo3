library(shiny)

ui <- fluidPage(
  shiny::selectInput(inputId = "dd", label = "Choose data", choices = c("mtcars", "iris")),
  tableOutput("data_table")
)

server <- function(input, output) {
  output$data_table <- renderTable({
    if (input$dd == "mtcars") {
      head(mtcars)
    } else {
      head(iris)
    }
  })
}

shinyApp(ui = ui, server = server)
