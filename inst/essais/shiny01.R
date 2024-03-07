library(shiny)
library(freewall)

ui <- fluidPage(
  freewallOutput("fw")
)

server <- function(input, output, session) {
  output$fw <- renderFreewall({
    freewall(alphabet(), widths = 200, cellW = 200, cellH = "auto")
  })
}

shinyApp(ui, server)

