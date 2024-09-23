using WooldridgeDatasets, GLM, DataFrames

hseinv = DataFrame(wooldridge("hseinv"))

# add lags and detrend:
reg_trend = lm(@formula(linvpc ~ t), hseinv)
hseinv.linvpc_det = residuals(reg_trend)
hseinv.gprice_lag1 = lag(hseinv.gprice, 1)
hseinv.linvpc_det_lag1 = lag(hseinv.linvpc_det, 1)

# Koyck geometric d.l.:
reg_koyck = lm(@formula(linvpc_det ~ gprice +
                                     linvpc_det_lag1), hseinv)
table_koyck = coeftable(reg_koyck)
println("table_koyck: \n$table_koyck\n")

# rational d.l.:
reg_rational = lm(@formula(linvpc_det ~ gprice + linvpc_det_lag1 +
                                        gprice_lag1), hseinv)
table_rational = coeftable(reg_rational)
println("table_rational: \n$table_rational\n")

# calculate LRP as...
# gprice / (1 - linvpc_det_lag1):
lrp_koyck = coef(reg_koyck)[2] / (1 - coef(reg_koyck)[3])
println("lrp_koyck = $lrp_koyck\n")

# and (gprice + gprice_lag1) / (1 - linvpc_det_lag1):
lrp_rational = (coef(reg_rational)[2] + coef(reg_rational)[4]) /
               (1 - coef(reg_rational)[3])
println("lrp_rational = $lrp_rational")