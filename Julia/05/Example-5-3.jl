using WooldridgeDatasets, GLM, DataFrames, Distributions

crime1 = DataFrame(wooldridge("crime1"))

# 1. estimate restricted model:
reg_r = lm(@formula(narr86 ~ pcnv + ptime86 + qemp86), crime1)
r2_r = r2(reg_r)
println("r2_r = $r2_r\n")

# 2. regression of residuals from restricted model:
crime1.utilde = residuals(reg_r)
reg_LM = lm(@formula(utilde ~
                pcnv + ptime86 + qemp86 + avgsen + tottime), crime1)
r2_LM = r2(reg_LM)
println("r2_LM = $r2_LM\n")

# 3. calculation of LM test statistic:
LM = r2_LM * nobs(reg_LM)
println("LM = $LM\n")

# 4. critical value from chi-squared distribution, alpha=10%:
cv = quantile(Chisq(2), 1 - 0.10)
println("cv = $cv\n")

# 5. p value (alternative to critical value):
pval = 1 - cdf(Chisq(2), LM)
println("pval = $pval\n")

# 6. compare to F test:
reg_ur = lm(@formula(narr86 ~
                pcnv + ptime86 + qemp86 + avgsen + tottime), crime1)
# hypotheses: "avgsen = 0" and "tottime = 0"
reg_r = lm(@formula(narr86 ~ pcnv + ptime86 + qemp86), crime1)
ftest_res = ftest(reg_r.model, reg_ur.model)

fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")