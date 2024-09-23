using Random, GLM, DataFrames, Distributions, Statistics

# set the random seed:
Random.seed!(12345)

# set sample size and number of simulations:
n = 1000
r = 10000

# set true parameters (betas and sd of u):
beta0 = 1
beta1 = 0.5
su = 2
sx = 1
ex = 4

# initialize b0 and b1 to store results later:
b0 = zeros(r)
b1 = zeros(r)

# repeat r times:
for i in 1:r
        # draw a sample:
        x = rand(Normal(ex, sx), n)
        u = rand(Normal(0, su), n)
        y = beta0 .+ beta1 .* x .+ u
        df = DataFrame(y=y, x=x)
        # estimate OLS:
        reg = lm(@formula(y ~ x), df)
        b0[i] = coef(reg)[1]
        b1[i] = coef(reg)[2]
end