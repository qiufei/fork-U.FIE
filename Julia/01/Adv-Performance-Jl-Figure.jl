using Random, DataFrames, Distributions, Plots, BenchmarkTools, CSV
# set the random seed:
Random.seed!(12345)

function simMean(n, reps)
    ybar = zeros(reps)
    for j in 1:reps
        # sample from normal distribution of size n
        sample = rand(Normal(), n)
        ybar[j] = mean(sample)
    end
    return ybar
end

# call the function multiple times and measure each time:
n = 100
r = 10000
step_length = 100
reps = range(100, r, step=100)
runTimeJl = zeros(Int(r / step_length))

for i in eachindex(reps)
    t = @benchmark simMean($n, $reps[$i])
    runTimeJl[i] = mean(t).time / 1e9 # mean(t).time in nanoseconds 
end

runtimeDf = DataFrame(runtime=runTimeJl)
CSV.write("Jlprocessed/01/Adv-Performance-Jl.csv", runtimeDf)

# import results (all in seconds):
R = CSV.read("Jlprocessed/01/Adv-Performance-R.csv", DataFrame)
Py = CSV.read("Jlprocessed/01/Adv-Performance-Py.csv", DataFrame)
Jl = CSV.read("Jlprocessed/01/Adv-Performance-Jl.csv", DataFrame)

# plot results
x_range = collect(reps)
plot(x_range, Jl.runtime, linestyle=:solid, color=:black,
    label="Julia", legend=:topleft)
plot!(x_range, R.runtime, linestyle=:dash, color=:black, label="R")
plot!(x_range, Py.runtime, linestyle=:dot, color=:black, label="Python")
xlabel!("Repetitions")
ylabel!("Runtime [seconds]")
savefig("JlGraphs/Adv-CompSpeed.pdf")


### Python-Code

# import random
# import numpy as np
# import timeit
# import pandas as pd
# import scipy.stats as stats

# np.random.seed(12345)

# def simMean(n, reps):
#     ybar = np.empty(reps)
#     for j in range(1, reps):
#         sample = stats.norm.rvs(0,1,size=n)
#         ybar[j] = np.mean(sample)
#     return(ybar)

# # call the function multiple times and measure each time:
# n = 100
# r = 10000
# step_length = 100
# reps = range(100, r+1, step_length)
# runTime = np.empty(len(reps))
# number = 100

# for i in range(len(reps)):
#     runTime[i] = timeit.repeat(lambda: simMean(
#         n, reps[i]), number=100, repeat=1)[0] / number
# # repeat gives total time, i.e. number * single iteration time

# dfruntime = pd.DataFrame({"runtime": runTime})
# dfruntime.to_csv("Jlprocessed/01/Adv-Performance-Py.csv")


### R-Code

# library(microbenchmark)
# library(rio)

# set.seed(12345)

# simMean <- function(n, reps){
#   ybar <- numeric(reps)
#   for(j in 1:reps){
#     sample <- rnorm(n)
#     ybar[j] <- mean(sample)
#   }
#   return(ybar)
# }

# # call the function multiple times and measure each time:
# n <- 100
# r <- 10000
# step_length <- 100
# reps <- seq(100, r, by=100)
# runtime <- numeric(R/step_length)


# for (i in 1:length(reps)){
#   t <- microbenchmark( simMean(n,reps[i]), unit = "s")
#   runtime[i] <- mean(t$time) / 1e9 # t$time in nanoseconds
# }

# export(as.data.frame(runtime),file="Jlprocessed/01/Adv-Performance-R.csv")