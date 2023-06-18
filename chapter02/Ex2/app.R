#!/usr/bin/env Rscript

library(shiny)

ui = fluidPage(
    sliderInput("numbers", 
                "0 to 100", 
                min = 0, 
                max = 100, 
                step = 5, 
                value = 0,
                animate = TRUE)
)

server = function(input, output, session) {
    # do nothing
}

shinyApp(ui, server)