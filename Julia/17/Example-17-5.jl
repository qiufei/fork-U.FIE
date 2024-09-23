using WooldridgeDatasets, GLM, DataFrames, Distributions

# load data and build data matrices:
mroz = DataFrame(wooldridge("mroz"))

# step 1 (use all n observations to estimate a probit model of s_i on z_i):
reg_probit = glm(@formula(inlf ~ educ + exper +
                                 (exper^2) + nwifeinc +
                                 age + kidslt6 + kidsge6),
    mroz, Binomial(), ProbitLink())
pred_inlf_linpart = quantile.(Normal(), fitted(reg_probit))
mroz.inv_mills = pdf.(Normal(), pred_inlf_linpart) ./
                 cdf.(Normal(), pred_inlf_linpart)

# step 2 (regress y_i on x_i and inv_mills in sample selection):
mroz_subset = subset(mroz, :inlf => ByRow(==(1)))
reg_heckit = lm(@formula(lwage ~ educ + exper + (exper^2) +
                                 inv_mills), mroz_subset)

# print results:
table_reg_heckit = coeftable(reg_heckit)
println("table_reg_heckit: \n$table_reg_heckit")