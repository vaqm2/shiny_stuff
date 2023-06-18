#!/usr/bin/env Rscript

nba_teams = list(`East1` = list("Knicks", 
                               "Nets",
                               "Bulls", 
                               "Heat"),
                 `East2` = list("Pacers", 
                               "Celtics",
                               "Hornets",
                               "Hawks"),
                 `West1` = list("Lakers",
                                "Warriors",
                                "Blazers",
                                "Suns"),
                 `West2` = list("Spurs",
                                "Mavericks",
                                "Rockets",
                                "Jazz"))

library(shiny)

ui = fluidPage(
    selectInput("team", label = "Select your team", choices = nba_teams),
    "You chose: ",
    textOutput("your_choice")
)

server = function(input, output, session) {
    output$your_choice = renderText({
        input$team
    })
}

shinyApp(ui, server)