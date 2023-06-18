#!/usr/bin/env Rscript

library(shiny)
library(reactable)

ui = fluidPage(
    plotOutput("plot_random", width = "700px", height = "300px"),
    dataTableOutput("dt"),
    reactableOutput("react_dt")
)

server = function(input, output, session) {
    output$plot_random = renderPlot(plot(c(1:5), c(11:15)))
    output$dt = renderDataTable(mtcars, options = list(pageLength = 5, 
                                                       searching = FALSE, 
                                                       ordering = FALSE,
                                                       filtering = FALSE))
    output$react_dt = renderReactable(reactable(iris))
}

shinyApp(ui, server)