#!/usr/bin/env Rscript

library(shiny)

ui = fluidPage(
    sliderInput("number1", 
                label = "Choose first number", 
                min = 1, 
                max = 100, 
                value = 20),
    sliderInput("number2", 
                label = "Choose second number", 
                min = 1,
                max = 100, 
                value = 80),
    "Number1 * Number2 = ", 
    textOutput("product"),
    "Number1 * Number2 + 50 = ", 
    textOutput("product_plus_50"),
    "Number1 * Number2 - 50 = ", 
    textOutput("product_minus_50")
)

server = function(input, output, session) { 
   product = reactive({
       input$number1 * input$number2
       })
    
    output$product = renderText({
        product()
        })
    output$product_plus_50 = renderText({
        product_plus_50 = product() + 50
        product_plus_50
        })
    output$product_minus_50 = renderText({
        product_minus_50 = product() - 50
        product_minus_50
        })
}

shinyApp(ui, server)