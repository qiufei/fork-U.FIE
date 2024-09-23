using Plots, Distributions

# support of quadratic function
# (creates an array with 100 equispaced elements from -3 to 2):
x1 = range(start=-3, stop=2, length=100)
# function values for all these values:
y1 = x1 .^ 2

# plot quadratic function:
plot(x1, y1, linestyle=:solid, color=:black, legend=false)
savefig("JlGraphs/Graphs-Functions-a.pdf")

# same for normal density:
x2 = range(-4, 4, length=100)
y2 = pdf.(Normal(), x2)

# plot normal density:
plot(x2, y2, linestyle=:solid, color=:black, legend=false)
savefig("JlGraphs/Graphs-Functions-b.pdf")