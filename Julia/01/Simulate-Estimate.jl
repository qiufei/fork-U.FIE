using Distributions, Random

# set the random seed:
Random.seed!(12345)

# set sample size:
n = 100

# draw a sample given the population parameters:
sample1 = rand(Normal(10, 2), n)

# estimate the population mean with the sample average:
estimate1 = mean(sample1)
println("estimate1 = $estimate1\n")

# draw a different sample and estimate again:
sample2 = rand(Normal(10, 2), n)
estimate2 = mean(sample2)
println("estimate2 = $estimate2\n")

# draw a third sample and estimate again:
sample3 = rand(Normal(10, 2), n)
estimate3 = mean(sample3)
print("estimate3: $estimate3")