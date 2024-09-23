using WooldridgeDatasets, GLM, DataFrames, Distributions

mroz = DataFrame(wooldridge("mroz"))

# estimate probit model:
reg_probit = glm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) + age +
                                 kidslt6 + kidsge6),
    mroz, Binomial(), ProbitLink())
ll = deviance(reg_probit) / -2

# test of overall significance (test statistic and p value):
reg_probit_null = glm(@formula(inlf ~ 1), mroz, Binomial(), ProbitLink())
ll_null = deviance(reg_probit_null) / -2
lr1 = 2 * (ll - ll_null)
pval_all = 1 - cdf(Chisq(7), lr1)
println("lr1 = $lr1\n")
println("pval_all = $pval_all\n")

# likelihood ratio statistic test of H0 (experience and age are irrelevant):
reg_probit_hyp = glm(@formula(inlf ~ nwifeinc + educ + kidslt6 + kidsge6),
    mroz, Binomial(), ProbitLink())
ll_hyp = deviance(reg_probit_hyp) / -2
lr2 = 2 * (ll - ll_hyp)
pval_hyp = 1 - cdf(Chisq(3), lr2)
println("lr2 = $lr2\n")
println("pval_hyp = $pval_hyp")