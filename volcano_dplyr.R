library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)

# Define UI
ui <- fluidPage(
  titlePanel("Volcano Plot dplyr"),
  sidebarLayout(
    sidebarPanel(
      fileInput("datafile", "Upload CSV", accept = ".csv"),
      uiOutput("group_select"),
      radioButtons("test_type", "Select Statistical Test:", 
                   choices = c("t-test" = "t_test", "Welch ANOVA" = "welch_anova"), 
                   selected = "t_test"),
      actionButton("analyze", "Analyze"), 
      textOutput("runtime"),           # adding system run time
      verbatimTextOutput("runtime_history")
    ),
    mainPanel(
      plotOutput("volcano_plot"),
      tableOutput("results_table")
    )
  )
)

# Define Server
server <- function(input, output, session) {
  data <- reactive({
    req(input$datafile)
    read.csv(input$datafile$datapath, header = TRUE)
  })
  
  output$group_select <- renderUI({
    req(data())
    groups <- unique(data()$Group)
    tagList(
      pickerInput("reference", "Select Reference Group", choices = groups, multiple = FALSE),
      pickerInput("comparisons", "Select Comparison Groups", choices = groups, multiple = FALSE)
    )
  })
    
  
  runtime_text <- reactiveVal("")  # Store runtime display
  runtime_log <- reactiveValues(history = character())
  
  results <- eventReactive(input$analyze, {
    req(input$reference, input$comparisons)
    df <- data()
    
    start_time <- Sys.time() 
    
    results <- df %>%
      group_by(Gene) %>%
      summarise(
        log2FC = log2(mean(Expression[Group %in% input$comparisons]) / mean(Expression[Group == input$reference])),
        p_value = if (input$test_type == "t_test") {
          t.test(Expression[Group %in% input$comparisons], Expression[Group == input$reference])$p.value
        } else {
          oneway.test(Expression ~ Group, data = df[df$Group %in% c(input$reference, input$comparisons), ])$p.value
        }
      )
    
    # Track runtime
    end_time <- Sys.time()
    duration <- round(difftime(end_time, start_time, units = "secs"), 2)
    runtime_text(paste("Calculation Runtime:", duration, "seconds"))
    timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    
    entry <- paste0(
      "[", timestamp, "] ",
      "Runtime: ", duration, " seconds | ",
      "Comparison: ", input$comparisons, " vs ", input$reference
    )
    
    # Append to runtime history
    runtime_log$history <- c(runtime_log$history, entry)
    
    results
  })
  
  output$results_table <- renderTable({
    req(results())
    results()
  })
  
  output$volcano_plot <- renderPlot({
    req(results())
    df <- results()
    #df$Significance <- ifelse(df$p_value < 0.05, "Significant", "Not Significant")
    df$Significance <- ifelse(df$p_value < 0.05 & abs(df$log2FC) > 1.5, "Significant", "Not Significant")
    ggplot(df, aes(x = log2FC, y = -log10(p_value), color = Significance)) +
      geom_point(size = 3) +
      geom_vline(xintercept = c(-1.5, 1.5), linetype = "dashed") +
      geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
      labs(title = "Volcano Plot", x = "Log2 Fold Change", y = "-Log10 P-Value") +
      theme_minimal()
    })


  output$runtime <- renderText({
    runtime_text()
  })
  
  output$runtime_history <- renderText({
    paste(runtime_log$history, collapse = "\n")
  })
}
# Run the App
shinyApp(ui = ui, server = server)
