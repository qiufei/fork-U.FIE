using WooldridgeDatasets, DataFrames, HypothesisTests

inven = DataFrame(wooldridge("inven"))
inven.lgdp = log.(inven.gdp)

# automated ADF:
adf_lag = 1
res_ADF_aut = ADFTest(inven.lgdp, :trend, adf_lag)
println("res_ADF_aut: \n$res_ADF_aut")