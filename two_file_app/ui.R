# user interface ----
ui <- navbarPage(
  
  theme = "shiny_fresh_theme.css",
  
  title = "LTER Animal Data Explorer",
  
  tabPanel(title = "About this page",
           
           # intro text fluidRow ----
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), #END intro text fluidRow
           
           hr(),
           
           includeMarkdown("text/footer.md")
           
  ), #END (page 1) intro tabPanel
  
  tabPanel(title = "Explore the Data",
           
           #tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             #trout tabPanel ----
             tabPanel(title = "Trout", 
                      
                      #trout sidebarLayout ---
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerinput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE), #END pickerInput
                          
                          #section checkboxGroupButton ----
                          checkboxGroupButtons(inputId = "section_input", 
                                               label = "Select a sampling section(s):",
                                               choices = c("clear cut forest", "old growth forest"),
                                               selected = c("clear cut forest", "old growth forest"), 
                                               individual = FALSE, justified = TRUE, size = "sm",
                                               checkIcon = list(yes = icon("check", lib = "font-awesome"),
                                                                no = icon("xmark", lib = "font-awesome"))), #END section checkboxGroupInput
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          #trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            withSpinner(color = "red", type = 1, size = 2)
                          
                        ) # END trout mainPanel
                        
                      )# END trout sidebarLayout
                      
             ), #END Trout tabPanel
             
             #penguin tabPanel ----
             
             tabPanel(title = "Penguins",
                      
                      #penguins sidebarLayout ---
                      sidebarLayout(
                        
                        #penguins sidebarPanel
                        sidebarPanel(
                          
                          # Island type pickerinput
                          pickerInput(inputId = "island_input",
                                      label = "Select island(s):",
                                      choices = unique(penguins$island),
                                      selected = c("Dream"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE), #END pickerInput
                          
                          #section slider ----
                          sliderInput(inputId = "bins_input",
                                      label = "Move slider to show how many bins you like",
                                      min = 1, max = 50, value = 20)
                          
                        ), #END penguins sidebarPanel
                        
                        #penguin mainPanel
                        mainPanel(
                          
                          #penguin histogram output
                          plotOutput(outputId = "penguins_histogram_output") %>% 
                            withSpinner(color = "red", type = 1, size = 2)
                          
                        ) #END penguin mainPanel
                        
                      ) #END penguin sidebarLayout
                      
             ) #End Penguin tabPanel
             
           ) #End tabsetPanel
           
  ) #END (page 2) data viz tabPanel
  
) # END navbarPage