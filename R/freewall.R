#' The 'freewall' widget
#' @description Creates a grid of images.
#'
#' @param images character vector of paths or urls to some images; for a
#'   Shiny app, the image files must be located in the www subfolder
#' @param backgroundImages Boolean, whether to render the images with the
#'   CSS property \code{background-image} or with \code{img} elements
#' @param widths the widths of the images in pixels; if a single value is given,
#'   it will be used for all images
#' @param heights the heights of the images in pixels; if a single value is given,
#'   it will be used for all images; setting the heights is necessary if
#'   \code{backgroundImages=TRUE}, otherwise this argument can be set to
#'   \code{NULL}
#' @param width the width of the container
#' @param draggable Boolean, whether to enable draggability
#' @param animate Boolean, whether to animate
#' @param cellW width of unit, a number of pixels or \code{"auto"}
#' @param cellH height of unit, a number of pixels or \code{"auto"}
#' @param delay time delay for showing an item
#' @param fixSize see \href{https://kombai.github.io/freewall/#options}{freewall options}
#' @param gutterX space between columns, a number of pixels or \code{"auto"}
#' @param gutterY space between rows, a number of pixels or \code{"auto"}
#' @param keepOrder Boolean, whether to keep the order of the images
#' @param rightToLeft Boolean, whether to let the layout start render from
#'   right to left
#' @param bottomToTop Boolean, whether to let the layout start render from
#'   bottom to top
#' @param elementId a HTML id for the container (usually useless)
#'
#' @return A \code{htmlwidget} object.
#' @export
#' @importFrom htmlwidgets createWidget
#' @importFrom jquerylib jquery_core
#' @importFrom htmltools htmlDependency validateCssUnit
#'
#' @examples
#' freewall(
#'   nature(), widths = 200, cellW = 200, cellH = 200, draggable = TRUE
#' )
freewall <- function(
    images,
    backgroundImages = FALSE,
    widths = 100,
    heights = NULL,
    width = "100%",
    draggable = FALSE,
    animate = TRUE,
    cellW = 100,
    cellH = 100,
    delay = 0,
    fixSize = NULL,
    gutterX = 10,
    gutterY = 10,
    keepOrder = TRUE,
    rightToLeft = FALSE,
    bottomToTop = FALSE,
    elementId = NULL
  ) {

  if(length(widths) == 1L) {
    widths <- rep(widths, length(images))
  } else {
    if(length(widths) != length(images)) {
      stop(
        "The `widths` argument must be of length one or of the same length ",
        "as the `images` vector."
      )
    }
  }

  if(backgroundImages && is.null(heights)) {
    stop(
      "If `backgroundImages=TRUE`, the `heights` argument cannot be `NULL`."
    )
  }

  if(!is.null(heights)) {
    if(length(heights) == 1L) {
      heights <- rep(heights, length(images))
    } else {
      if(length(heights) != length(images)) {
        stop(
          "The `heights` argument must be of length one or of the same length ",
          "as the `images` vector."
        )
      }
    }
  }

  # forward options using x
  x <- list(
    images = images,
    display = ifelse(backgroundImages, "url", "img"),
    widths = widths,
    heights = heights,
    width = validateCssUnit(width),
    draggable = draggable,
    animate = animate,
    cellW = cellW,
    cellH = cellH,
    delay = delay,
    fixSize = fixSize,
    gutterX = gutterX,
    gutterY = gutterY,
    keepOrder = keepOrder,
    rightToLeft = rightToLeft,
    bottomToTop = bottomToTop
  )
  # create widget
  createWidget(
    name = "freewall",
    x,
    width = NULL,
    height = NULL,
    package = "freewall",
    elementId = elementId,
    dependencies = list(
      jquery_core(major_version = 3, minified = TRUE),
      htmlDependency(
        name = "freewall",
        version = "1.0.6",
        src = "htmlwidgets/lib/freewall",
        script = "freewall.js",
        package = "freewall"
      )
    )
  )
}

#' @title Shiny bindings for 'freewall'
#'
#' @description Output and render functions for using \code{freewall} within
#'   Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height a valid CSS dimension (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended
#' @param expr an expression that generates a \code{\link{freewall}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted logical, whether \code{expr} is a quoted expression
#'   (with \code{quote()}); this is useful if you want to save an expression
#'   in a variable
#'
#' @return \code{freewallOutput} returns an output element that can be included
#'   in a Shiny UI definition, and \code{renderFreewall} returns a
#'   \code{shiny.render.function} object that can be included in a Shiny server
#'   definition.
#'
#' @examples
#' if(require(shiny) && interactive()) {
#' library(shiny)
#' library(freewall)
#'
#' ui <- fluidPage(
#'   freewallOutput("fw")
#' )
#'
#' server <- function(input, output, session) {
#'   output$fw <- renderFreewall({
#'     freewall(alphabet(), widths = 200, cellW = 200, cellH = "auto")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name freewall-shiny
#'
#' @export
#' @importFrom htmlwidgets shinyWidgetOutput shinyRenderWidget
freewallOutput <- function(outputId, width = "100%", height = "auto"){
  shinyWidgetOutput(outputId, "freewall", width, height, package = "freewall")
}

#' @rdname freewall-shiny
#' @export
renderFreewall <- function(expr, env = parent.frame(), quoted = FALSE) {
  if(!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, freewallOutput, env, quoted = TRUE)
}
