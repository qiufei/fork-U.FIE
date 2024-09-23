using Distributions, DataFrames, GLM, Random, Plots, KernelDensity, LinearAlgebra

# set the random seed:
Random.seed!(12345)

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
    # draw a sample of x, fixed over replications:
    x = rand(Normal(ex, sx), j)
    # repeat r times:
    for i in 1:r
        # draw a sample of u (standardized chi-squared[1]):
        u = (rand(Chisq(1), j) .- 1) ./ sqrt(2)
        y = beta0 .+ beta1 .* x .+ u
        df = DataFrame(y=y, x=x)
        # estimate conditional OLS:
        reg = lm(@formula(y ~ x), df)
        b1[i] = coef(reg)[2]
    end
    # simulated density:
    kde_sim = KernelDensity.kde(b1)

    # normal density/ compute mu and se
    X = [fill(1.0, (length(x), 1)) x]
    Vbhat = sx .* inv(transpose(X) * X)
    se = sqrt.(diag(Vbhat))
    x_range = range(minimum(b1), maximum(b1), r)
    y = pdf.(Normal(beta1, se[2]), x_range)

    # plotting:
    filename = "JlGraphs/MCSim-olsasy-chisq-n$j.pdf"
    plot(kde_sim.x, kde_sim.density, color="black", label="b1")
    plot!(x_range, y, line=:dash, color="black", label="normal distribution")
    ylabel!("density")
    savefig("$filename")
end


# Normal vs. Chisq

# support of normal density:
x_range = range(-4, 4, 100)

# pdf for all these values:
pdf_n = pdf.(Normal(), x_range)
pdf_c = pdf.(Chisq.(1), x_range * sqrt(2) .+ 1)

# plot:
plot(x_range, pdf_n, line=:line, color=:black, linewidth=2, label="standard normal")
plot!(x_range, pdf_c, line=:dash, color=:black, linewidth=2, label="standardized chi squared[1]")
ylabel!("dx")
xlabel!("x")
savefig("JlGraphs/MCSim-olsasy-stdchisq.pdf")