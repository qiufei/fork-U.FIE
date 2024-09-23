using WooldridgeDatasets, GLM, DataFrames

mroz = DataFrame(wooldridge("mroz"))

# estimate models:
reg_lin = lm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                             kidslt6 + kidsge6), mroz)
reg_logit = glm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                                kidslt6 + kidsge6),
     mroz, Binomial(), LogitLink())
reg_probit = glm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                                 kidslt6 + kidsge6),
     mroz, Binomial(), ProbitLink())

# predictions for two "extreme" women:
X_new = DataFrame(nwifeinc=[100, 0], educ=[5, 17],
     exper=[0, 30], age=[20, 52],
     kidslt6=[2, 0], kidsge6=[0, 0])
predictions_lin = round.(predict(reg_lin, X_new), digits=5)
predictions_logit = round.(predict(reg_logit, X_new), digits=5)
predictions_probit = round.(predict(reg_probit, X_new), digits=5)

println("predictions_lin = $predictions_lin\n")
println("predictions_logit = $predictions_logit\n")
println("predictions_probit = $predictions_probit")