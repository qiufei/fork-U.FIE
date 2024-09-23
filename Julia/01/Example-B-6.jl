using Distributions

# first example using the transformation:
p1_1 = cdf(Normal(), 2 / 3) - cdf(Normal(), -2 / 3)
println("p1_1 = $p1_1\n")

# first example working directly with the distribution of X:
p1_2 = cdf(Normal(4, 3), 6) - cdf(Normal(4, 3), 2)
println("p1_2 = $p1_2\n")

# second example:
p2 = 1 - cdf(Normal(4, 3), 2) + cdf(Normal(4, 3), -2)
println("p2 = $p2")