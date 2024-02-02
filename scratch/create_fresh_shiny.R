library(fresh)
  
  create_theme(
  
  theme = "default",
  bs_vars_global(
    
    body_bg = "maroon",
    text_color = "white",
    link_color = "seagreen"
    
  ),
  
  bs_vars_navbar(
    
    default_bg = "blue",
    default_color = "gray"
    
  ),
  
  bs_vars_tabs(
    
    border_color = "darkorange"
    
  ),
  
  output_file = "two_file_app/www/shiny_fresh_theme.css"
    
)




