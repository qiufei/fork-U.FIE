using Plots

# create data:
x = [1, 3, 4, 7, 8, 9]
y = [0, 3, 6, 9, 7, 8]

# plot and save:
plot(x, y, color=:black)
savefig("JlGraphs/Graphs-Basics-a.pdf")

# scatter and save:
scatter(x, y, color=:black, markershape=:dtriangle, legend=false)
savefig("JlGraphs/Graphs-Basics-b.pdf")