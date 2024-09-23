using Random, Distributions, Statistics, Plots

# set the random seed:
Random.seed!(12345)

# initialize plot:
x_range = range(0, 50, 51)
plot(xlims=(0, 50), ylims=(-25, 25))

# loop over draws:
for r in 1:30
    # i.i.d. standard normal shock:
    e = rand(Normal(0, 1), 51)

    # set first entry to 0 (gives y_0 = 0):
    e[1] = 0

    # random walk as cumulative sum of shocks:
    y = cumsum(e)

    # add line to graph:
    plot!(x_range, y, color="lightgrey", legend=false)
end

hline!([0], color="black", linewidth=2, linestyle=:dash)
xlabel!("time")
ylabel!("y")
savefig("JlGraphs/Simulate-RandomWalk.pdf")