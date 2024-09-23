using Distributions, Random, KernelDensity, Plots

# set the random seed:
Random.seed!(12345)

# set sample size:
n = 100

# initialize ybar to an array of length r=10000 to later store results:
r = 10000
ybar = zeros(r)

# repeat r times:
for j in 1:r
    # draw a sample and store the sample mean in pos. j=1,... of ybar:
    sample = rand(Normal(10, 2), n)
    ybar[j] = mean(sample)
end

# the first 8 of 10000 estimates:
ybar_preview = round.(ybar[1:8], digits=4)
println("ybar_preview: \n$ybar_preview\n")

# simulated mean:
mean_ybar = mean(ybar)
println("mean_ybar = $mean_ybar\n")

# simulated variance:
var_ybar = var(ybar)
println("var_ybar = $var_ybar")

# simulated density:
kde = KernelDensity.kde(ybar)

# normal density:
x_range = range(9, 11, length=100)
y = pdf.(Normal(10, sqrt(0.04)), x_range)

# create graph:
plot(kde.x, kde.density, color=:black, label="ybar", linewidth=2)
plot!(x_range, y, linestyle=:dash, color=:black,
    label="normal distribution", linewidth=2)
ylabel!("density")
xlabel!("ybar")
savefig("JlGraphs/Simulation-Repeated-Results.pdf")