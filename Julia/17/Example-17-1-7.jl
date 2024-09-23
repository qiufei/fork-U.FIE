using WooldridgeDatasets, GLM, DataFrames, Statistics,
    Distributions, LinearAlgebra

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

# average partial effects:
APE_lin = coef(reg_lin)

coefs_logit = coef(reg_logit)
xb_logit = reg_logit.mm.m * coefs_logit
factor_logit = mean(pdf.(Logistic(), xb_logit))
APE_logit = coefs_logit * factor_logit

coefs_probit = coef(reg_probit)
xb_probit = reg_probit.mm.m * coefs_probit
factor_probit = mean(pdf.(Normal(), xb_probit))
APE_probit = coefs_probit * factor_probit

# print results:
table_manual = DataFrame(
    coef_names=coeftable(reg_lin).rownms,
    APE_lin=round.(APE_lin, digits=5),
    APE_logit=round.(APE_logit, digits=5),
    APE_probit=round.(APE_probit, digits=5))
println("table_manual: \n$table_manual")