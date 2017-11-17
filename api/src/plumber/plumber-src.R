#' Test function
#' @serializer unboxedJSON
#' @get /test
#' @post /test
test <- function(n, wait = 0.5, ...) {
    Sys.sleep(wait)
    list(value = n)
}
