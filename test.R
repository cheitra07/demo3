library(shiny)

# Define UI
ui <- fluidPage(
  # Checkbox input
  checkboxInput("show_table", "Show Table", value = FALSE),
  
  # Table output
  tableOutput("data_table")
)

# Define server logic
server <- function(input, output) {
  # Reactive expression to generate data
  data <- reactive({
    # Sample data frame
    data.frame(
      ID = 1:5,
      Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
      Score = c(85, 92, 78, 90, 88)
    )
  })
  
  # Render table based on checkbox input
  output$data_table <- renderTable({
    if (input$show_table) {
      data()
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
