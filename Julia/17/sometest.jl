
# estimate logit model:
reg_logit = glm(@formula(y ~ x1 + x2 + x3), sample, Binomial(), LogitLink())
reg_probit = glm(@formula(y ~ x1 + x2 + x3), sample, Binomial(), ProbitLink())


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

predictions_lin2 = round.(predict(reg_lin), digits=5)
