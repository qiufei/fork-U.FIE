using WooldridgeDatasets, DataFrames, GLM, Statistics

ceosal1 = DataFrame(wooldridge("ceosal1"))

# OLS regression:
reg = lm(@formula(salary ~ roe), ceosal1)

# obtain predicted values and residuals:
sal_hat = predict(reg)
u_hat = residuals(reg)

# calculate R^2 in three different ways:
sal = ceosal1.salary
R2_a = var(sal_hat) / var(sal)
R2_b = 1 - var(u_hat) / var(sal)
R2_c = cor(sal, sal_hat)^2

println("R2_a = $R2_a\n")
println("R2_b = $R2_b\n")
println("R2_c = $R2_c")