using WooldridgeDatasets, GLM, DataFrames

crime1 = DataFrame(wooldridge("crime1"))

# estimate linear model:
reg_lin = lm(@formula(narr86 ~ pcnv + avgsen + tottime + ptime86 + qemp86 +
                               inc86 + black + hispan + born60), crime1)
table_lin = coeftable(reg_lin)
println("table_lin: \n$table_lin\n")

# estimate Poisson model:
reg_poisson = glm(@formula(narr86 ~ pcnv + avgsen + tottime + ptime86 + qemp86 +
                                    inc86 + black + hispan + born60),
    crime1, Poisson())
table_poisson = coeftable(reg_poisson)
println("table_poisson: \n$table_poisson\n")

# estimate Quasi-Poisson model:
yhat = predict(reg_poisson)
resid = crime1.narr86 .- yhat
sigma_sq = 1 / (2725 - 9 - 1) * sum(resid .^ 2 ./ yhat)
table_qpoisson = coeftable(reg_poisson)
table_qpoisson.cols[2] = table_qpoisson.cols[2] * sqrt(sigma_sq)
println("table_qpoisson: \n$table_qpoisson")