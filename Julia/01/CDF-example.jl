using Distributions

# binomial CDF:
p1 = cdf(Binomial(10, 0.2), 3)
println("p1 = $p1\n")

# normal CDF:
p2 = cdf(Normal(), 1.96) - cdf(Normal(), -1.96)
println("p2 = $p2")