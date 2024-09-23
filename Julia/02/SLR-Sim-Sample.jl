using Random, GLM, DataFrames, Distributions, Statistics, Plots

# set the random seed:
Random.seed!(12345)

# set sample size:
n = 1000

# set true parameters (betas and sd of u):
beta0 = 1
beta1 = 0.5
su = 2

# draw a sample of size n:
x = rand(Normal(4, 1), n)
u = rand(Normal(0, su), n)
y = beta0 .+ beta1 .* x .+ u
df = DataFrame(y=y, x=x)

# estimate parameters by OLS:
reg = lm(@formula(y ~ x), df)
b = coef(reg)
println("b = $b\n")

# features of the sample for the variance formula:
x_sq_mean = mean(x .^ 2)
println("x_sq_mean = $x_sq_mean\n")
x_var = sum((x .- mean(x)) .^ 2)
println("x_var = $x_var")

# graph:
x_range = range(0, 8, length=100)
scatter(x, y, color="lightgrey", ylim=[-2, 10],
    label="sample", alpha=0.7, markerstrokecolor=:white)
plot!(x_range, beta0 .+ beta1 .* x_range, color="black",
    linestyle=:solid, linewidth=2, label="pop. regr. fct.")
plot!(x_range, coef(reg)[1] .+ coef(reg)[2] .* x_range, color="grey",
    linestyle=:solid, linewidth=2, label="OLS regr. fct.")
xlabel!("x")
ylabel!("y")
savefig("JlGraphs/SLR-Sim-Sample.pdf")