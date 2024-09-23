using Random, Distributions, Statistics, Plots, GLM, DataFrames

# set the random seed:
Random.seed!(12345)

# i.i.d. N(0,1) innovations:
n = 51
e = rand(Normal(), n)
e[1] = 0
a = rand(Normal(), n)
a[1] = 0

# independent random walks:
x = cumsum(a)
y = cumsum(e)
sim_data = DataFrame(y=y, x=x)

# regression:
reg = lm(@formula(y ~ x), sim_data)
reg_table = coeftable(reg)
println("reg_table: \n$reg_table")

# graph:
plot(x, color="black", linewidth=2, linestyle=:solid, label="x")
plot!(y, color="black", linewidth=2, linestyle=:dash, label="y")
ylabel!("y")
xlabel!("x")
savefig("JlGraphs/Simulate-Spurious-Regression-1.pdf")