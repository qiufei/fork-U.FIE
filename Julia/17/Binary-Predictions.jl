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

# prediction for regular grid of x values:
X_new = DataFrame(x=range(minimum(x), maximum(x), length=50))
predictions_lin = predict(reg_lin, X_new)
predictions_logit = predict(reg_logit, X_new)
predictions_probit = predict(reg_probit, X_new)

# scatter plot and fitted values:
scatter(x, y, label=false, color="black", legend=:topleft)
plot!(X_new.x, predictions_lin, linewidth=2,
    label="linear", color="black")
plot!(X_new.x, predictions_logit, linewidth=2,
    label="logit", color="black", linestyle=:dash)
plot!(X_new.x, predictions_probit, linewidth=2,
    label="probit", color="black", linestyle=:dot)
ylabel!("y")
xlabel!("x")
savefig("JlGraphs/Binary-Predictions.pdf")


