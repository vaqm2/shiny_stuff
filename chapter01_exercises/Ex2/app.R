#!/usr/bin/env Rscript

library(shiny)

largest_prime = function(num1, num2) {
    smaller = min(num1, num2)
    larger = max(num1, num2)
    prime = NA
    for(i in larger:smaller) {
        if(!any(i %% c((i-1):2) == 0)) {
            prime = i
            break
        }
    }
    return(prime)
}

ui = fluidPage(
    sliderInput("number1", "Choose first number", min = 2, max = 100, value = 25),
    sliderInput("number2", "Choose second number", min = 2, max = 100, value = 75),
    textOutput("prime_number")
)

server = function(input, output, session) {
    output$prime_number = renderText({
        paste0("Largest prime number between ",
               input$number1,
               " and ",
               input$number2,
               " is ",
               largest_prime(input$number1, input$number2))
    })
}

shinyApp(ui, server)