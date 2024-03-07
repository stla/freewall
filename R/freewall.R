#' The 'freewall' widget
#' @description Creates a grid of images.
#'
#' @param images character vector of paths or urls to some images
#' @param widths the widths of the images in pixels; if it is a single value,
#'   this value will be used for all images
#' @param width container width
#' @param draggable Boolean, whether to enable draggability
#' @param animate Boolean, whether to animate
#' @param cellW width of unit, a number of pixels or \code{"auto"}
#' @param cellH height of unit, a number of pixels or \code{"auto"}
#' @param delay time delay for showing a block
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
#' freewall(alphabet(), widths = 200, draggable = TRUE)
freewall <- function(
    images,
    widths = 100,
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
  # forward options using x
  x <- list(
    images = images,
    widths = widths,
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

#' Shiny bindings for freewall
#'
#' Output and render functions for using freewall within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a freewall
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
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
