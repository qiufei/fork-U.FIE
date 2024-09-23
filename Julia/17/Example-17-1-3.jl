using WooldridgeDatasets, GLM, DataFrames

mroz = DataFrame(wooldridge("mroz"))

# estimate logit model:
reg_logit = glm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                                kidslt6 + kidsge6),
    mroz, Binomial(), LogitLink())
table_reg_logit = coeftable(reg_logit)
println("table_reg_logit: \n$table_reg_logit\n")

# log likelihood value:
ll = deviance(reg_logit) / -2
println("ll = $ll\n")

# McFadden's pseudo R2:
reg_logit_null = glm(@formula(inlf ~ 1), mroz, Binomial(), LogitLink())
ll_null = deviance(reg_logit_null) / -2
pr2 = 1 - ll / ll_null
println("pr2 = $pr2")