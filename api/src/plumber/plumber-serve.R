library(plumber)
r <- plumb("/home/docker/plumber/plumber-src.R")
r$run(port=9000, host="0.0.0.0")
