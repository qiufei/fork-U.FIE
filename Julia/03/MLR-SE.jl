using WooldridgeDatasets, DataFrames, GLM, Statistics

gpa1 = DataFrame(wooldridge("gpa1"))

# full estimation results including automatic SE:
reg = lm(@formula(colGPA ~ hsGPA + ACT), gpa1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# calculation of SER via residuals:
n = nobs(reg)
k = length(coef(reg))
SER = sqrt(sum(residuals(reg) .^ 2) / (n - k))

# regressing hsGPA on ACT for calculation of R2 & VIF:
reg_hsGPA = lm(@formula(hsGPA ~ ACT), gpa1)
R2_hsGPA = r2(reg_hsGPA)
VIF_hsGPA = 1 / (1 - R2_hsGPA)
println("VIF_hsGPA = $VIF_hsGPA\n")

# manual calculation of SE of hsGPA coefficient:
sdx = std(gpa1.hsGPA) * sqrt((n - 1) / n)
SE_hsGPA = 1 / sqrt(n) * SER / sdx * sqrt(VIF_hsGPA)
println("SE_hsGPA = $SE_hsGPA")