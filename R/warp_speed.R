#' Warp Speed
#' 
#' Converts warp factor to speed in meters/second
#' @param warpfactor Warp factor to be converted
#' @param originalseries Defaults to FALSE. Warp speed is different in The
#'   Original Series than in later series. Set to TRUE if you want to use the 
#'   format for TOS.
#' @author Kara Woo
#' @export
#' @references
#' \url{http://www.anycalculator.com/warpcalculator.htm}

warp_speed <- function(warpfactor, originalseries = FALSE) {
  if (!is.numeric(warpfactor)) {
    stop("Warp factor must be numeric.")
  }
  if (originalseries == FALSE & warpfactor > 10) {
    stop("Warp factor cannot exceed 10 in series other than The Original Series")
  }
  
  if (originalseries == TRUE) {
    v <- (warpfactor^3) * 299792458 
  } else if (originalseries == FALSE) {
    if (warpfactor > 9.0 & warpfactor <= 10.0) {
      x <- -0.5 * log10(10 - warpfactor) 
    } else {
      x <- 0
    }
    v <- (warpfactor^((10/3) + x)) * 299792458
  }
  v
}