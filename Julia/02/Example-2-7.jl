using WooldridgeDatasets, DataFrames, GLM, Statistics

wage1 = DataFrame(wooldridge("wage1"))
reg = lm(@formula(wage ~ educ), wage1)

# obtain coefficients, predicted values and residuals:
b = coef(reg)
wage_hat = predict(reg)
u_hat = residuals(reg)

# confirm property (1):
u_hat_mean = mean(u_hat)
println("u_hat_mean = $u_hat_mean\n")

# confirm property (2):
educ_u_cov = cov(wage1.educ, u_hat)
println("educ_u_cov = $educ_u_cov\n")

# confirm property (3):
educ_mean = mean(wage1.educ)
wage_pred = b[1] + b[2] * educ_mean
println("wage_pred = $wage_pred\n")

wage_mean = mean(wage1.wage)
println("wage_mean = $wage_mean")