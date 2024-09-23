using Plots

# create data:
x = [1, 3, 4, 7, 8, 9]
y = [0, 3, 6, 9, 7, 8]

# plot and save:
plot(x, y, color=:black, linestyle=:dash, legend=false)
savefig("JlGraphs/Graphs-Basics-c.pdf")

plot(x, y, color=:black, linestyle=:dot, legend=false)
savefig("JlGraphs/Graphs-Basics-d.pdf")

plot(x, y, color=:black, linestyle=:solid, linewidth=3, legend=false)
savefig("JlGraphs/Graphs-Basics-e.pdf")

plot(x, y, color=:black, markershape=:circle, legend=false)
savefig("JlGraphs/Graphs-Basics-f.pdf")