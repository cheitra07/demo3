library(shiny)
library(DT)

# Define UI
ui <- fluidPage(
  checkboxGroupInput("dataset", "Choose Dataset(s):",
                     choices = c("Iris" = "iris", "Mtcars" = "mtcars")),
  DTOutput("data_table")
)

# Define server logic
server <- function(input, output) {
  output$data_table <- renderDT({
    if ("iris" %in% input$dataset) {
      datatable(iris)
    } else if ("mtcars" %in% input$dataset) {
      datatable(mtcars)
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
