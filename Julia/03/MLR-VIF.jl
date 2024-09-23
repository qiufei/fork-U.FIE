using WooldridgeDatasets, DataFrames, GLM

wage1 = DataFrame(wooldridge("wage1"))

# get VIF:
m_1 = lm(@formula(educ ~ exper + tenure), wage1)
Vif_1 = 1 / (1 - r2(m_1))
println("Vif_1 = $Vif_1")

m_2 = lm(@formula(exper ~ educ + tenure), wage1)
Vif_2 = 1 / (1 - r2(m_2))
println("Vif_2 = $Vif_2")

m_3 = lm(@formula(tenure ~ educ + exper), wage1)
Vif_3 = 1 / (1 - r2(m_3))
println("Vif_3 = $Vif_3")