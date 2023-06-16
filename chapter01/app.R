#!/usr/bin/Rscript 

library(shiny)

# Defines the user interface

# fluidPage -> layout function that sets the layout of the page

ui = fluidPage(
    selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
    verbatimTextOutput("summary"),
    tableOutput("table")
)

# Defines behaviour of the app with a function

server = function(input, output, session) {
    dataset = reactive({
        get(input$dataset, "package:datasets")
    })
    
    output$summary = renderPrint({
        summary(dataset())
    })
    output$table = renderTable({
        dataset()
    })
}

# Constructs a shiny app from UI and server

shinyApp(ui, server)