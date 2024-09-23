using Plots, Distributions, Random, KernelDensity

##################
## LLN (normal) ##
##################

# set the random seed:
Random.seed!(12345)

# set sample sizes and MC simulations:
n = [10, 50, 100, 1000]
r = 10000

# support of normal density (fixed):
x_range = range(8.5, 11.5, length=100)

for i in n
    ybar = zeros(r)
    for j in 1:r
        # sample of size n
        sample = rand(Normal(10, 2), i)
        ybar[j] = mean(sample)
    end
    # simulated density:
    kde = KernelDensity.kde(ybar)

    # normal density:
    y = pdf.(Normal(10, 2 / sqrt(i)), x_range)

    # plotting:
    filename = "JlGraphs/MCSim-lln-n" * string(i) * ".pdf"

    plot(kde.x, kde.density, color=:black, label="ybar")
    plot!(x_range, y, linestyle=:dash, color=:black, label="normal distribution")
    xlims!((8.5, 11.5))
    ylims!((0, 6.5))
    ylabel!("density")
    xlabel!("ybar")
    savefig(filename)
end

##################
## CLT (chisq) ##
##################

# density:
x_range = range(0, 3, length=100)

y = pdf.(Chisq(1), x_range)
plot(x_range, y, linestyle=:solid, color=:black, legend=false)
ylabel!("density")
xlabel!("x")
savefig("JlGraphs/MCSim-chisqdens.pdf")

# set the random seed:
Random.seed!(123456)

# set sample sizes and MC simulations:
n = [2, 10, 100, 10000]
r = 10000

for i in n
    ybar = zeros(r)
    for j in 1:r
        # sample of size n
        sample = rand(Chisq(1), i)
        ybar[j] = mean(sample)
    end

    # simulated density:
    kde = KernelDensity.kde(ybar)

    # normal density:
    x_range = range(minimum(ybar), maximum(ybar), length=50)
    y = pdf.(Normal(1, sqrt(2 / i)), x_range)

    # plotting:
    filename = "JlGraphs/MCSim-clt-n" * string(i) * ".pdf"
    plot(kde.x, kde.density, color=:black, label="ybar")
    plot!(x_range, y, linestyle=:dash, color=:black, label="normal distribution")
    ylabel!("density")
    xlabel!("ybar")
    savefig(filename)
end