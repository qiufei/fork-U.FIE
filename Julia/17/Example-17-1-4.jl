using WooldridgeDatasets, GLM, DataFrames

mroz = DataFrame(wooldridge("mroz"))

# estimate probit model:
reg_probit = glm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                                 kidslt6 + kidsge6),
    mroz, Binomial(), ProbitLink())
table_reg_probit = coeftable(reg_probit)
println("table_reg_probit: \n$table_reg_probit\n")

# log likelihood value:
ll = deviance(reg_probit) / -2
println("ll=$ll\n")

# McFadden's pseudo R2:
reg_probit_null = glm(@formula(inlf ~ 1), mroz, Binomial(), ProbitLink())
ll_null = deviance(reg_probit_null) / -2
pr2 = 1 - ll / ll_null
println("pr2 = $pr2")