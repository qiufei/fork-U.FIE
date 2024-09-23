using Distributions, GLM, Random, Plots, DataFrames

# set the random seed:
Random.seed!(12345)

y = rand(Binomial(1, 0.5), 100)
x = rand(Normal(), 100) + 2 * y
sim_data = DataFrame(y=y, x=x)

# estimation:
reg_lin = lm(@formula(y ~ x), sim_data)
reg_logit = glm(@formula(y ~ x), sim_data, Binomial(), LogitLink())
reg_probit = glm(@formula(y ~ x), sim_data, Binomial(), ProbitLink())

# partial effects:
PE_lin = range(coef(reg_lin)[2], coef(reg_lin)[2], length=100)

coefs_logit = coeftable(reg_logit).cols[1]
xb_logit = reg_logit.mm.m * coefs_logit
factor_logit = pdf.(Logistic(), xb_logit)
PE_logit = coefs_logit[2] * factor_logit

coefs_probit = coeftable(reg_probit).cols[1]
xb_probit = reg_probit.mm.m * coefs_probit
factor_probit = pdf.(Normal(), xb_probit)
PE_probit = coefs_probit[2] * factor_probit

# plot PE's:
scatter(x, PE_lin, markershape=:circle, label="linear",
    color="black", legend=:topleft)
scatter!(x, PE_logit, markershape=:cross, label="logit",
    color="black", legend=:topleft)
scatter!(x, PE_probit, markershape=:star, label="probit",
    color="black", legend=:topleft)
ylabel!("partial effects")
xlabel!("x")
savefig("JlGraphs/Binary-margeff.pdf")