#!/usr/bin/env Rscript

library(vroom)
library(shiny)
library(tidyverse)

# Acquire data from Hadley's github repository

url_path   = "https://github.com/hadley/mastering-shiny/raw/main/neiss/"
injuries   = vroom(paste0(url_path, "injuries.tsv.gz"))
population = vroom(paste0(url_path, "population.tsv"))
products   = vroom(paste0(url_path, "products.tsv"))
prod_codes = setNames(products$prod_code, products$title)

ui = fluidPage(
    fluidRow(
        column(10, 
               selectInput("product", 
                           "Select Product", 
                           choices = prod_codes)),
        column(2,
               selectInput("type",
                           "Rate/Count",
                           choices = c("Rate", "Count")))),
    fluidRow(
        column(4, dataTableOutput("diag")),
        column(4, dataTableOutput("body_part")),
        column(4, dataTableOutput("location"))
    ),
    fluidRow(
        column(8, plotOutput("plot_by_age_sex"))
    ),
    fluidRow(
        column(2, actionButton("report", "Show case reports")),
        column(8, dataTableOutput("case_report"))
    )
)

server = function(input, output, session) {
    selected_product = reactive(injuries %>% filter(prod_code == input$product))
    
    summary = reactive({
        selected_product() %>%
            count(age, sex, wt = weight) %>% 
            left_join(population, by = c("age", "sex")) %>%
            mutate(rate = (n * 1e4)/population)
    })
    
    display_options = reactive({
        list(pageLength = 5, 
             searching = FALSE, 
             ordering = FALSE,
             filtering = FALSE)
    })
    
    case_reports = eventReactive(input$report, selected_product() %>%
                                    select(narrative))
    
    output$diag = renderDataTable(selected_product() %>% 
                                      count(diag, 
                                            wt = weight, 
                                            sort = TRUE), 
        options = display_options())
    
    output$body_part = renderDataTable(selected_product() %>% 
                                           count(body_part, 
                                                 wt = weight, 
                                                 sort = TRUE), 
        options = display_options())
    
    output$location = renderDataTable(selected_product() %>% 
                                          count(location, 
                                                wt = weight, 
                                                sort = TRUE),
        options = display_options())
    
    output$plot_by_age_sex = renderPlot({
        if(input$type == "Count") {
            ggplot(summary() %>% na.omit(), aes(x = age, color = sex, y = n)) +
                geom_point(shape = 21) + 
                geom_line() + 
                theme_classic() + 
                ylab("Count") +
                scale_color_manual(values = c("red", "blue"))
        } else if(input$type == "Rate") {
            ggplot(summary() %>% na.omit(), aes(x = age, color = sex, y = rate)) +
                geom_point(shape = 21) + 
                geom_line() + 
                theme_classic() +
                ylab("Per 100,000 individuals") +
                scale_color_manual(values = c("red", "blue"))
        }
    })
    
    output$case_report = renderDataTable(case_reports(), 
                                         options = display_options())
}

shinyApp(ui, server)