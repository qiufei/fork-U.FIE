using GLM, Random, Distributions, Statistics, Plots, DataFrames

# set the random seed:
Random.seed!(12345)

x = sort(rand(Normal(), 100) .+ 4)
y = -4 .+ 1 * x .+ rand(Normal(), 100)
compl = DataFrame(x=x, y=y)

sample = (y .> 0)

# complete observations and observed sample:
x_sample = x[sample]
y_sample = y[sample]

sample = DataFrame(x=x_sample, y=y_sample)

# predictions OLS:
reg_ols = lm(@formula(y ~ x), sample)
yhat_ols = fitted(reg_ols)

# predictions truncated regression:
reg_tr = lm(@formula(y ~ x), compl)
yhat_tr = fitted(reg_tr)


# plot data and conditional means:
hline([0], color="grey", label=false, legend=:topleft)
scatter!(compl.x, compl.y, color="black", markershape=:circle,
    markercolor=:white, label="all data")
scatter!(sample.x, sample.y, color="black", markershape=:circle,
    label="sample data")
plot!(sample.x, yhat_ols, color="black", linewidth=2,
    linestyle=:dash, label="OLS fit")
plot!(compl.x, yhat_tr, color="black", linewidth=2,
    linestyle=:solid, label="Trunc. Reg. fit")
ylabel!("y")
xlabel!("x")
savefig("JlGraphs/TruncReg-Simulation.pdf")