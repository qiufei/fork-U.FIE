using Random, Distributions, Statistics, GLM, DataFrames

# set the random seed:
Random.seed!(12345)

# set sample size and number of simulations:
n = 1000
r = 10000

# set true parameters (betas):
beta0 = 1
beta1 = 0.5

# initialize arrays to store results later (b1 without ME, b1_me with ME):
b1 = zeros(r)
b1_me = zeros(r)

# draw a sample of x, fixed over replications:
x = rand(Normal(4, 1), n)

# repeat r times:
for i in 1:r
        # draw a sample of u:
        u = rand(Normal(0, 1), n)

        # draw a sample of ystar:
        ystar = beta0 .+ beta1 * x .+ u

        # measurement error and mismeasured y:
        e0 = rand(Normal(0, 1), n)
        y = ystar .+ e0
        df = DataFrame(ystar=ystar, y=y, x=x)

        # regress ystar on x and store slope estimate at position i:
        reg_star = lm(@formula(ystar ~ x), df)
        b1[i] = coef(reg_star)[2]

        # regress y on x and store slope estimate at position i:
        reg_me = lm(@formula(y ~ x), df)
        b1_me[i] = coef(reg_me)[2]
end

# mean with and without ME:
b1_mean = mean(b1)
b1_me_mean = mean(b1_me)
println("b1_mean = $b1_mean\n")
println("b1_me_mean = $b1_me_mean\n")

# variance with and without ME:
b1_var = var(b1)
b1_me_var = var(b1_me)
println("b1_var = $b1_var\n")
println("b1_me_var = $b1_me_var")