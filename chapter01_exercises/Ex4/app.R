#!/usr/bin/env Rscript

library(shiny)
library(ggplot2)

datasets = c("economics", "faithfuld", "seals")

ui = fluidPage(
    selectInput("dataset", label = "Datasets", choices = datasets),
    verbatimTextOutput("summary"),
    imageOutput("plot_img")
)

server = function(input, output, session) {
    dataset = reactive({
        get(input$dataset, "package:ggplot2")
    })
    
    output$summary = renderPrint({
        summary(dataset())
    })
    
    output$plot_img = renderPlot({
        plot(dataset())
    }, res = 96)
}

shinyApp(ui, server)