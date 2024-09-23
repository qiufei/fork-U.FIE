using Random, Distributions, Statistics, Plots

# set the random seed:
Random.seed!(12345)

x = sort(rand(Normal(), 100) .+ 4)
xb = -4 .+ 1 * x
y_star = xb .+ rand(Normal(), 100)
y = copy(y_star)
y[y_star.<0] .= 0

# conditional means:
Eystar = xb
Ey = cdf.(Normal(), xb) .* xb .+ pdf.(Normal(), xb)

# plot data and conditional means:
hline([0], color="grey", label=false, legend=:topleft)
scatter!(x, y_star, color="black", markershape=:xcross, label="y*")
scatter!(x, y, color="black", markershape=:cross, label="y")
plot!(x, Eystar, color="black", linewidth=2, linestyle=:solid, label="E(y*)")
plot!(x, Ey, color="black", linewidth=2, linestyle=:dash, label="E(y)")
ylabel!("y")
xlabel!("x")
savefig("JlGraphs/Tobit-CondMean.pdf")