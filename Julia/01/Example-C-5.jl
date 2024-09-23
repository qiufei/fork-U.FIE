using WooldridgeDatasets, DataFrames, Distributions, HypothesisTests

audit = DataFrame(wooldridge("audit"))
y = audit.y

# automated calculation of t statistic for H0 (mu=0):
test_auto = OneSampleTTest(y, 0)
t_auto = test_auto.t # access test statistic
p_auto = pvalue(test_auto, tail=:left)  # access one-sided p value
println("t_auto = $t_auto\n")
println("p_auto = $p_auto\n")

# manual calculation of t statistic for H0 (mu=0):
avgy = mean(y)
n = length(y)
sdy = std(y)
se = sdy / sqrt(n)
t_manual = avgy / se
println("t_manual = $t_manual\n")

# critical values for t distribution with n-1=240 d.f.:
alpha_one_tailed = [0.1, 0.05, 0.025, 0.01, 0.005, 0.001]
CV = quantile(TDist(n - 1), 1 .- alpha_one_tailed)
table = DataFrame(alpha_one_tailed=alpha_one_tailed, CV=CV)
println("table: \n$table")