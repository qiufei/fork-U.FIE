using Distributions, Random

Random.seed!(12345)
# sample from a standard normal RV with sample size n=3:
sample1 = rand(Normal(), 3)
println("sample1: $sample1\n")

# a different sample from the same distribution:
sample2 = rand(Normal(), 3)
println("sample2: $sample2\n")

# set the seed of the random number generator and take two samples:
Random.seed!(54321)
sample3 = rand(Normal(), 3)
println("sample3: $sample3\n")

sample4 = rand(Normal(), 3)
println("sample4: $sample4\n")

# reset the seed to the same value to get the same samples again:
Random.seed!(54321)
sample5 = rand(Normal(), 3)
println("sample5: $sample5\n")

sample6 = rand(Normal(), 3)
println("sample6: $sample6")