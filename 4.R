library(shiny)
library(readr)

ui <- fluidPage(
  fileInput("namefile","upload file",accept=c(".txt",".csv")),
  tableOutput("content"),
  downloadButton("downloadData", "Download")
 # downloadLink()
)

server <- function(input, output, session) {
  data<-reactive({
    req(input$namefile)
    ext<-tools::file_ext(input$namefile$name)
     switch(ext,
           txt=read_delim(input$namefile$datapath,delim='\t'),
           csv =read_csv(input$namefile$datapath),
           validate("'invalid file extension"))
  })
  output$content<-renderTable({
    data()
  })
 output$downloadData <-downloadHandler(
  filename=function(){paste("data_",Sys.Date(),".csv",sep="")},
  content =function(file){write_csv(data(),file)}
  
  )
}

shinyApp(ui, server)