using WooldridgeDatasets, GLM, DataFrames, Econometrics

card = DataFrame(wooldridge("card"))

# checking for relevance with reduced form:
reg_redf = lm(@formula(educ ~ nearc4 + exper + (exper^2) + black +
                              smsa + south + smsa66 + reg662 +
                              reg663 + reg664 + reg665 + reg666 +
                              reg667 + reg668 + reg669), card)
table_redf = coeftable(reg_redf)
println("table_redf: \n$table_redf\n")

# OLS:
reg_ols = lm(@formula(log(wage) ~ educ + exper + (exper^2) + black +
                                  smsa + south + smsa66 + reg662 +
                                  reg663 + reg664 + reg665 + reg666 +
                                  reg667 + reg668 + reg669), card)
table_ols = coeftable(reg_ols)
println("table_ols: \n$table_ols\n")


# IV automatically:
reg_iv = fit(EconometricModel,
    @formula(log(wage) ~ exper + (exper^2) + black + smsa +
                         south + smsa66 + reg662 + reg663 +
                         reg664 + reg665 + reg666 + reg667 +
                         reg668 + reg669 + (educ ~ nearc4)), card)
table_iv = coeftable(reg_iv)
println("table_iv: \n$table_iv")