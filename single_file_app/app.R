#load packages ---------
library(shiny)
library(palmerpenguins)
library(tidyverse)

#user interface --------
ui <- fluidPage(
  
  # app title ----
  tags$h1("My app title"),
  
  #app subtitle ----
  h4(strong("Exploring antarctic penguin data")),
  
  #body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g):",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  #body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output"),
  
  #year checkbox datatable input ----
  checkboxGroupInput(inputId = "year_input",
                     label= "Year of interest:",
                     choices = unique(penguins$year),
                     selected = c("2007", "2008")),
  
  #year checkbox datatable output ----
  DT::dataTableOutput(outputId = "year_output")
  
) #establishes page of ui (where people can view in the web browser)

#server ---------
server <- function(input, output) {
  
  #filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  #render penguin scatter plot
  output$bodyMass_scatterplot_output <- renderPlot({
    
    # add ggplot code here
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
    
  })
  
  #filter year ----
  year_df <- reactive({
    
    penguins %>% 
      filter(year %in% c(input$year_input))
    
  })
    
  # render DT table ----
  output$year_output <- DT::renderDataTable({
    
    DT::datatable(year_df())
    
    })
  
}

# combine UI and server into app ----
shinyApp(ui = ui, server = server)

