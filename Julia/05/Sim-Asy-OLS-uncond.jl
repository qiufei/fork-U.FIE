using Distributions, DataFrames, GLM, Random

# set the random seed:
Random.seed!(12345)

# set sample size and number of simulations:
n = 100
r = 10000

# set true parameters:
beta0 = 1
beta1 = 0.5
sx = 1
ex = 4

# initialize b1 to store results later:
b1 = zeros(r)

# repeat r times:
for i in 1:r
    # draw a sample of x, varying over replications:
    x = rand(Normal(ex, sx), n)
    # draw a sample of u (std. normal):
    u = rand(Normal(0, 1), n)
    y = beta0 .+ beta1 .* x .+ u
    df = DataFrame(y=y, x=x)
    # estimate unconditional OLS:
    reg = lm(@formula(y ~ x), df)
    b1[i] = coef(reg)[2]
end