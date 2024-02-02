# dashboardHeader ------
header <- dashboardHeader(
  
  #title -----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
) #END dashboardHeader



#dashboardSidebar ----
sidebar <- dashboardSidebar(
  
  #sidebar ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  )#END sidebarMenu
  
) 

#dashboardBody ----
body <- dashboardBody(
  
  #tabItems ----
  tabItems(
    
    #welcome tabItem ----
    tabItem(tabName = "welcome",
            
            #left-hand column ----
            column(width = 6,
                   
                   #background info box ----
                   box(width = NULL,
                       
                       "BACKGROUND info here"
                       
                   )#END background box
                   
            ),#END column
            
            #right-hand column ----
            column(width = 6,
                   
                   #first fluidRow ----
                   fluidRow(
                     
                     #citation box ----
                     box(width = NULL,
                         
                         "citation here"
                         
                     )#END citation box
                     
                   ),#END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     #disclaimer box ----
                     box(width = NULL,
                         
                         "disclaimer here"
                         
                     )#END disclaimer box
                     
                   )#END second fluidRow
                   
            )#END right-hand column
            
    ), #END welcome tabItem
    
    #dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            #fluidRow ----
            fluidRow(
              
              #input box ----
              box(width = 4,
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  #sliderInputs_elevation ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL):",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))
                  ), #END sliderInputs_elevation
                  
                  #sliderInputs_depths
                  sliderInput(inputId = "depth_slider_input",
                              label = "Average Depth (meters):",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),
                                        max(lake_data$AvgDepth))
                  ), #END sliderinputs_depth
                  
                  #sliderinputs_temp
                  sliderInput(inputId = "temp_slider_input",
                              label = "Average Depth (C):",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp))
                  )#END sliderinputs_temp
                  
              ), #END input box
              
              #map box ----
              box(width = 8,
                  
                  title = strong("Monitoring Lakes within Fish Creek Watershed:"),
                  
                  #leaflet output ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1, color = "#4287f5")
                  
              )# END map box
              
            ) #END fluidRow
            
    ) #END dashboard tabItem
    
  )#END tabItems
  
)

#combine all in dashboardPage ----
dashboardPage(header, sidebar, body)