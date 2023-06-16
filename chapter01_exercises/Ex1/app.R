#!/usr/bin/env Rscript

library(shiny)

ui = fluidPage(
    textInput("name", 
              label = "", 
              value = "", 
              placeholder = "First Name"),
    textOutput("greeting")
)

server = function(input, output, session) {
   output$greeting = renderText({
       paste0("Hello ", input$name, "!")})
}

shinyApp(ui, server)