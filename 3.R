library(shiny)
library(readr)
#########

ui <- fluidPage(
  fileInput("file", "Upload File", accept = c(".txt", ".csv")),
  tableOutput("contents"),
  downloadButton("downloadData", "Download")
)

server <- function(input, output) {
  data <- reactive({
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    switch(ext,
           txt = read_delim(input$file$datapath, delim = "\t"),
           csv = read_csv(input$file$datapath),
           validate("Invalid file; Please upload a .txt or .csv file"))
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write_csv(data(), file)
    }
  )
}

shinyApp(ui, server)
