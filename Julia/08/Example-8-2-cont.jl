using PyCall, WooldridgeDatasets, GLM, DataFrames
include("../03/getMats.jl")

# install Python's statsmodels with: using Conda; Conda.add("statsmodels")
sm = pyimport("statsmodels.api")

gpa3 = DataFrame(wooldridge("gpa3"))
gpa3_subset = subset(gpa3, :spring => ByRow(==(1)))

# F test using usual VCOV in Julia:
reg_ur = lm(@formula(cumgpa ~ sat + hsperc + tothrs + female + black + white),
    gpa3_subset)
reg_r = lm(@formula(cumgpa ~ sat + hsperc + tothrs + female),
    gpa3_subset)
ftest_res = ftest(reg_r.model, reg_ur.model)
fstat_jl = ftest_res.fstat[2]
fpval_jl = ftest_res.pval[2]
println("fstat_jl = $fstat_jl\n")
println("fpval_jl = $fpval_jl\n")

# F test using different variance-covariance formulas:
# definition of model and hypotheses:
f = @formula(cumgpa ~ 1 + sat + hsperc + tothrs + female + black + white)
xy = getMats(f, gpa3_subset)
reg = sm.OLS(xy[1], xy[2])
hypotheses = ["x5 = 0", "x6 = 0"] # meaning "black = 0" and "white = 0"

# usual VCOV in Python:
results_default = reg.fit()
ftest_py_default = results_default.f_test(hypotheses)
fstat_py_default = ftest_py_default.statistic
fpval_py_default = ftest_py_default.pvalue
println("fstat_py_default = $fstat_py_default\n")
println("fpval_py_default = $fpval_py_default\n")

# classical White VCOV in Python:
results_hc0 = reg.fit(cov_type="HC0")
ftest_py_hc0 = results_hc0.f_test(hypotheses)
fstat_py_hc0 = ftest_py_hc0.statistic
fpval_py_hc0 = ftest_py_hc0.pvalue
println("fstat_py_hc0 = $fstat_py_hc0\n")
println("fpval_py_hc0 = $fpval_py_hc0")