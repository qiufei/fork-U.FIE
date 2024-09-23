using WooldridgeDatasets, GLM, DataFrames, PyCall
include("../03/getMats.jl")
iv3 = pyimport("linearmodels.system")

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# prepare for equation 1:
f1 = @formula(hours ~ 1 + educ + age + kidslt6 + nwifeinc)
yexog = getMats(f1, mroz)
y_eq1 = yexog[1]
exog_mat_eq1 = yexog[2]

f2 = @formula(1 ~ 0 + log(wage))
endo_mat_eq1 = getMats(f2, mroz)[2]

f3 = @formula(1 ~ 0 + exper + (exper^2))
iv_mat_eq1 = getMats(f3, mroz)[2]

# prepare for equation 2:
f1 = @formula(log(wage) ~ 1 + educ + exper + (exper^2))
yexog = getMats(f1, mroz)
y_eq2 = yexog[1]
exog_mat_eq2 = yexog[2]

f2 = @formula(1 ~ 0 + hours)
endo_mat_eq2 = getMats(f2, mroz)[2]

f3 = @formula(1 ~ 0 + age + kidslt6 + nwifeinc)
iv_mat_eq2 = getMats(f3, mroz)[2]

# use Python's linearmodels:
reg_3sls = iv3.IV3SLS(Dict([
    ("eq1", (y_eq1, exog_mat_eq1, endo_mat_eq1, iv_mat_eq1)),
    ("eq2", (y_eq2, exog_mat_eq2, endo_mat_eq2, iv_mat_eq2))]))
results_3sls = reg_3sls.fit(cov_type="unadjusted", debiased=true)
println("results_3sls: \n$results_3sls")