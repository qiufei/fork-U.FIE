using Distributions, Random

# set the random seed:
Random.seed!(12345)

# set sample size:
n = 100

# initialize ybar to an array of length r=10000 to later store results:
r = 10000
ybar = zeros(r)

# repeat r times:
for j in 1:r
    # draw a sample and store the sample mean in pos. j=1,... of ybar:
    sample = rand(Normal(10, 2), n)
    ybar[j] = mean(sample)
end