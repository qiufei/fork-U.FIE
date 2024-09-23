using Plots, Distributions

# support for all normal densities:
x = range(-4, 4, length=100)
# get different density evaluations:
y1 = pdf.(Normal(), x)
y2 = pdf.(Normal(1, 0.5), x)
y3 = pdf.(Normal(0, 2), x)

# plot:
plot(x, y1, linestyle=:solid, color=:black, label="standard normal")
plot!(x, y2, linestyle=:dash, color=:black,
    linealpha=0.6, label="mu = 1, sigma = 0.5")
plot!(x, y3, linestyle=:dot, color=:black,
    linealpha=0.3, label="mu = 0, sigma = 2")
xlims!(-3, 4)
title!("Normal Densities")
ylabel!("phi(x)")
xlabel!("x")
savefig("JlGraphs/Graphs-BuildingBlocks.pdf")