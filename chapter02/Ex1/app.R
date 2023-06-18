#!/usr/bin/env Rscript

library(shiny)

ui = fluidPage(
    textInput("name", "Enter Name", value = "", placeholder = "John Doe"),
    sliderInput("selected_date", 
                label = "Select delivery date", 
                min = as.Date("2023-07-01"),
                max = as.Date("2023-07-31"),
                value = as.Date("2023-07-15")),
    textOutput("greeting"),
    "Your order will be delivered on: ",
    textOutput("delivery_date")
)

server = function(input, output, session) {

    output$greeting = renderText({
        paste0("Hello ", input$name, "!")
    })
    output$delivery_date = renderText({
        as.character(input$selected_date)
    })
}

shinyApp(ui, server)