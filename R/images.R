#' Some images
#' @description Twenty-four urls pointing to an image.
#'
#' @return A character vector of 24 urls pointing to an image.
#' @export
#'
#' @examples
#' freewall(alphabet(), widths = 200, cellW = 200, cellH = "auto")
alphabet <- function() {
  Letters <-
    c(
      "LetterA.jpg",
      "LetterB.jpg",
      "LetterC.jpg",
      "LetterD.jpg",
      "LetterE.jpg",
      "LetterF.jpg",
      "LetterG.jpg",
      "LetterHI.jpg",
      "LetterJ.jpg",
      "LetterK.jpg",
      "LetterL.jpg",
      "LetterM.jpg",
      "LetterN.jpg",
      "LetterO.jpg",
      "LetterP.jpg",
      "LetterQR.jpg",
      "LetterS.jpg",
      "LetterT.jpg",
      "LetterU.jpg",
      "LetterV.jpg",
      "LetterW.jpg",
      "LetterX.jpg",
      "LetterY.jpg",
      "LetterZ.jpg"
    )
  paste0(
    "https://raw.githubusercontent.com/stla/freewall/main/inst/images/alphabet/",
    Letters
  )
}

#' Some images
#' @description Nine urls pointing to an image.
#'
#' @return A character vector of nine urls pointing to an image.
#' @export
#'
#' @examples
#' freewall(
#'   nature(), widths = 200, cellW = 200, cellH = "200", draggable = TRUE
#' )
nature <- function() {
  files <- paste0("nature-", 1L:9L, ".jpg")
  paste0(
    "https://raw.githubusercontent.com/stla/freewall/main/inst/images/nature/",
    files
  )
}
