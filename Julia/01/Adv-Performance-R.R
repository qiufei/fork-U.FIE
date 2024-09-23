library(microbenchmark)
library(rio)

set.seed(12345)

simMean <- function(n, reps) {
  ybar <- numeric(reps)
  for (j in 1:reps) {
    sample <- rnorm(n)
    ybar[j] <- mean(sample)
  }
  return(ybar)
}

# call the function multiple times and measure each time:
n <- 100
r <- 10000
step_length <- 100
reps <- seq(100, r, by = 100)
runtime <- numeric(r / step_length)


for (i in 1:length(reps)) {
  t <- microbenchmark(simMean(n, reps[i]), unit = "s")
  runtime[i] <- mean(t$time) / 1e9 # t$time in nanoseconds
}

export(as.data.frame(runtime), file = "Jlprocessed/01/Adv-Performance-R.csv")
