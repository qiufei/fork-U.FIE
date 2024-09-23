using Distributions, Plots

# binomial CDF:
x_binom = range(-1, 10, length=100)
cdf_binom = cdf.(Binomial(10, 0.2), x_binom)

plot(x_binom, cdf_binom, linetype=:steppre, color=:black, legend=false)
xlabel!("x")
ylabel!("Fx")
savefig("JlGraphs/CDF-figure-discrete.pdf")

# normal CDF:
x_norm = range(-4, 4, length=1000)
cdf_norm = cdf.(Normal(), x_norm)

plot(x_norm, cdf_norm, color=:black, legend=false)
xlabel!("x")
ylabel!("Fx")
savefig("JlGraphs/CDF-figure-cont.pdf")