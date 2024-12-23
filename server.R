library(shiny)
library(magick)

server <- function(input, output, session) {
  
  # Load a single image
  img_data <- reactive({
    req(input$image_file)
    tryCatch(
      image_read(input$image_file$datapath),
      error = function(e) { NULL } # Handle errors gracefully
    )
  })
  
  # Process RGB channels
  processed_image <- reactive({
    req(img_data())
    img <- img_data()
    list(
      red   = image_channel(img, "red"),
      green = image_channel(img, "green"),
      blue  = image_channel(img, "blue")
    )
  })
  
  # Compute metrics
  metrics <- reactive({
    req(processed_image())
    channels <- processed_image()
    
    if (!is.null(channels$green) && !is.null(channels$blue)) {
      # Convert channels to RGB
      green_rgb <- image_convert(channels$green, colorspace = "RGB")
      blue_rgb  <- image_convert(channels$blue, colorspace = "RGB")
      
      # Extract pixel data
      green_matrix <- as.numeric(image_data(green_rgb))
      blue_matrix  <- as.numeric(image_data(blue_rgb))
      
      # Calculate area and brightness
      green_area <- sum(green_matrix > 0)
      blue_area  <- sum(blue_matrix > 0)
      # Calculate brightness and multiply by 1000 for legibility
      green_bri <- mean(green_matrix)*1000
      blue_bri  <- mean(blue_matrix)*1000
      
      # Compute MarkToBlue ratio
      marktoblue_ratio <- (green_area * green_bri) / (blue_area * blue_bri)
      
      list(
        green_area      = green_area,
        blue_area       = blue_area,
        green_bri       = green_bri,
        blue_bri        = blue_bri,
        marktoblue_ratio = marktoblue_ratio
      )
    } else {
      NULL
    }
  })
  
  # Display image preview
  output$image_preview <- renderPlot({
    req(img_data())
    plot(as.raster(img_data()))
  })
  
  # Display metrics when analysis is started
  observeEvent(input$start_processing, {
    req(metrics())
    result <- metrics()
    
    output$metrics_result <- renderPrint({
      cat("Green area:", result$green_area, "\n")
      cat("Blue area:", result$blue_area, "\n")
      cat("Green Brightness:", round(result$green_bri, 2), "\n")
      cat("Blue Brightness:", round(result$blue_bri, 2), "\n")
      cat("Mark to Blue RATIO:", round(result$marktoblue_ratio, 2), "\n")
    })
  })
}
