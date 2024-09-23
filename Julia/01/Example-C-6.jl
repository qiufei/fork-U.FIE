using Distributions, HypothesisTests

# manually enter raw data from Wooldridge, Table C.3:
SR87 = [10, 1, 6, 0.45, 1.25, 1.3, 1.06, 3, 8.18, 1.67,
        0.98, 1, 0.45, 5.03, 8, 9, 18, 0.28, 7, 3.97]
SR88 = [3, 1, 5, 0.5, 1.54, 1.5, 0.8, 2, 0.67, 1.17, 0.51,
        0.5, 0.61, 6.7, 4, 7, 19, 0.2, 5, 3.83]
Change = SR88 .- SR87

# automated calculation of t statistic for H0 (mu=0):
test_auto = OneSampleTTest(Change, 0)
t_auto = test_auto.t
p_auto = pvalue(test_auto, tail=:left)
println("t_auto = $t_auto\n")
println("p_auto = $p_auto\n")

# manual calculation of t statistic for H0 (mu=0):
avgCh = mean(Change)
n = length(Change)
sdCh = std(Change)
se = sdCh / sqrt(n)
t_manual = avgCh / se
println("t_manual = $t_manual\n")

# manual calculation of p value for H0 (mu=0):
p_manual = cdf(TDist(n - 1), t_manual)
println("p_manual = $p_manual")