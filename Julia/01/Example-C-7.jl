using WooldridgeDatasets, DataFrames, Distributions, HypothesisTests

audit = DataFrame(wooldridge("audit"))
y = audit.y

# automated calculation of t statistic for H0 (mu=0):
test_auto = OneSampleTTest(y, 0)
t_auto = test_auto.t
p_auto = pvalue(test_auto, tail=:left)
println("t_auto = $t_auto\n")
println("p_auto = $p_auto\n")

# manual calculation of t statistic for H0 (mu=0):
avgy = mean(y)
n = length(y)
sdy = std(y)
se = sdy / sqrt(n)
t_manual = avgy / se
println("t_manual = $t_manual\n")

# manual calculation of p value for H0 (mu=0):
p_manual = cdf(TDist(n - 1), t_manual)
println("p_manual = $p_manual")