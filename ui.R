library(shiny)
# Allow bigger image sizes
options(shiny.maxRequestSize = 30 * 1024^2)

ui <- fluidPage(
  # Logo included
  tags$div(
    tags$img(src = "logo.png", height = "200px"), 
    style = "text-align: left; margin-bottom: 20px;"
  ),
  
  # Title panel
  titlePanel("MarkToBlue"),
  
  # Sidebar layout
  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "image_file",
        label = "Select an image...",
        # Formats accepted
        accept = c("image/png", "image/jpeg", "image/jpg", "image/tiff"),
        # Single input (no multiple allowed)
        multiple = FALSE
      ),
      # Action button after preview
      actionButton(
        inputId = "start_processing",
        label = "Start analysis"
      )
    ),
    mainPanel(
      h4("Loaded image"),
      plotOutput(outputId = "image_preview", height = "300px"),  # Display a single image preview
      verbatimTextOutput(outputId = "metrics_result")           # Display metrics
    )
  )
)
