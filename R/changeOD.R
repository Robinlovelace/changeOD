#' Explore changes in OD datasets over time
#' 
#' @param x Origin-destination dataset 1
#' @param y Origin-destination dataset 2
#' @return A plot comparing the two datasets
#' @examples 
#' \dontrun{
#' changeOD(x = od1, y = od2)
#' }
#' @export
changeOD <- function(x, y) {
  # Check if the datasets are of the same class
  if (class(x) != class(y)) {
    stop("The datasets are not of the same class")
  }
}
