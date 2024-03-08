library(shiny)
library(freewall)

css <- "
			#fw {
				margin: 15px;
			}
@keyframes start {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

@-webkit-keyframes start {
  from {
    -webkit-transform: scale(0);
  }
  to {
    -webkit-transform: scale(1);
  }
}

#fw .fw-item[data-state='init'] {
  display: none;
}

#fw .fw-item[data-state='start'] {
  display: block;
  animation: start 0.5s;
  -webkit-animation: start 0.5s;
}

#fw .fw-item[data-state='move'] {
  transition: top 0.5s, left 0.5s, width 0.5s, height 0.5s;
  -webkit-transition: top 0.5s, left 0.5s, width 0.5s, height 0.5s;
}
"

ui <- fluidPage(
  tags$head(tags$style(HTML(css))),
  freewallOutput("fw")
)

server <- function(input, output, session) {
  output$fw <- renderFreewall({
    freewall(
      nature(), backgroundImages = TRUE,
      widths = 200, heights = 200,
      cellW = 200, cellH = 200,
      animate = FALSE, delay = 50
    )
  })
}

shinyApp(ui, server)

