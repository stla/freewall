#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#' @importFrom jquerylib jquery_core
#' @importFrom htmltools htmlDependency
#'
#' @export
freewall <- function(images, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    images = images
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'freewall',
    x,
    width = width,
    height = height,
    package = 'freewall',
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
freewallOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'freewall', width, height, package = 'freewall')
}

#' @rdname freewall-shiny
#' @export
renderFreewall <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, freewallOutput, env, quoted = TRUE)
}
