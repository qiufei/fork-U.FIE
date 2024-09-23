using Distributions, DataFrames, GLM, Random, Plots, KernelDensity, LinearAlgebra

# set the random seed:
Random.seed!(12345678)

# set sample size and number of simulations:
n = [5, 10, 100, 1000]
r = 10000

# set true parameters:
beta0 = 1
beta1 = 0.5
sx = 1
ex = 4

for j in n
    # initialize b1 to store results later:
    b1 = zeros(r)
    # repeat r times:
    for i in 1:r
        # draw a sample of x, varying over replications:
        x = rand(Normal(ex, sx), j) #j
        # draw a sample of u (std. normal):
        u = rand(Normal(0, 1), j) #j
        y = beta0 .+ beta1 .* x .+ u
        df = DataFrame(y=y, x=x)

        # estimate unconditional OLS:
        reg = lm(@formula(y ~ x), df)
        b1[i] = coef(reg)[2]
    end
    # simulated density:
    kde_sim = KernelDensity.kde(b1)

    # normal density/ compute mu and se
    x = rand(Normal(ex, sx), j) #j
    X = [fill(1.0, (length(x), 1)) x]
    Vbhat = sx .* inv(transpose(X) * X)
    se = sqrt.(diag(Vbhat))
    x_range = range(minimum(b1), maximum(b1), r)
    y = pdf.(Normal(beta1, se[2]), x_range)

    # plotting:
    filename = "JlGraphs/MCSim-olsasy-uncond-n$j.pdf"
    plot(kde_sim.x, kde_sim.density, color="black", label="b1")
    plot!(x_range, y, line=:dash, color="black", label="normal distribution")
    ylabel!("density")
    savefig("$filename")
end


# kurtosis:
using StatsBase
Random.seed!(12345678)
j = 5
b1 = zeros(r)
# repeat r times:
for i in 1:r
    # draw a sample of x, varying over replications:
    x = rand(Normal(ex, sx), j) #j
    # draw a sample of u (std. normal):
    u = rand(Normal(0, 1), j) #j
    y = beta0 .+ beta1 .* x .+ u
    df = DataFrame(y=y, x=x)

    # estimate unconditional OLS:
    reg = lm(@formula(y ~ x), df)
    b1[i] = coef(reg)[2]
end
# simulated density:
kde_sim = KernelDensity.kde(b1)

# normal density/ compute mu and se
x = rand(Normal(ex, sx), j) #j
X = [fill(1.0, (length(x), 1)) x]
Vbhat = sx .* inv(transpose(X) * X)
se = sqrt.(diag(Vbhat))
x_range = range(minimum(b1), maximum(b1), r)
y = pdf.(Normal(beta1, se[2]), x_range)
plot(kde_sim.x, kde_sim.density, color="black", label="b1")
plot!(x_range, y, line=:dash, color="black", label="normal distribution")
ylabel!("density")

StatsBase.kurtosis(kde_sim.density) + 3
StatsBase.kurtosis(y)


x2 = rand(Normal(0, 1), 1000)
kurtosis(x2, m=0.0)