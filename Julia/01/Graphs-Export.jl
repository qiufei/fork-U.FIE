using Plots, Distributions

# support for all normal densities:
x = range(-4, 4, length=100)
# get different density evaluations:
y1 = pdf.(Normal(), x)
y2 = pdf.(Normal(0, 3), x)

# plot (a):
plot(legend=false, size=(400, 600))
plot!(x, y1, linestyle=:solid, color=:black)
plot!(x, y2, linestyle=:dash, color=:black, linealpha=0.3)
savefig("JlGraphs/Graphs-Export-a.pdf")

# plot (b):
plot(legend=false, size=(600, 400))
plot!(x, y1, linestyle=:solid, color=:black)
plot!(x, y2, linestyle=:dash, color=:black, linealpha=0.3)
savefig("JlGraphs/Graphs-Export-b.png")