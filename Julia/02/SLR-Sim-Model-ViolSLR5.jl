using Random, GLM, DataFrames, Distributions, Statistics

# set the random seed:
Random.seed!(1234567)

# set sample size and number of simulations:
n = 1000
r = 10000

# set true parameters (betas and sd of u):
beta0 = 1
beta1 = 0.5
su = 2

# initialize b0 and b1 to store results later:
b0 = zeros(r)
b1 = zeros(r)
# draw a sample of x, fixed over replications:
x = rand(Normal(4, 1), n)

# repeat r times:
for i in 1:r
        # draw a sample of y:
        u_var = 4 / exp(4.5) .* exp.(x)
        u = rand.(Normal.(0, sqrt.(u_var)), 1)
        u = reduce(vcat, u)
        y = beta0 .+ beta1 .* x .+ u
        df = DataFrame(y=y, x=x)
        # estimate and store parameters by OLS:
        reg = lm(@formula(y ~ x), df)

        b0[i] = coef(reg)[1]
        b1[i] = coef(reg)[2]
end

# MC estimate of the expected values:
b0_mean = mean(b0)
b1_mean = mean(b1)
println("b0_mean = $b0_mean\n")
println("b1_mean = $b1_mean\n")

# MC estimate of the variances:
b0_var = var(b0)
b1_var = var(b1)
println("b0_var = $b0_var\n")
println("b1_var = $b1_var")