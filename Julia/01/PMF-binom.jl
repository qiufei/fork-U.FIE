using Distributions

# pedestrian approach:
p1 = binomial(10, 2) * (0.2^2) * (0.8^8)
println("p1 = $p1\n")

# package function:
p2 = pdf(Binomial(10, 0.2), 2)
println("p2 = $p2")