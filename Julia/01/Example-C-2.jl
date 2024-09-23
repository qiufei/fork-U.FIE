using Distributions

# manually enter raw data from Wooldridge, Table C.3:
SR87 = [10, 1, 6, 0.45, 1.25, 1.3, 1.06, 3, 8.18, 1.67,
    0.98, 1, 0.45, 5.03, 8, 9, 18, 0.28, 7, 3.97]
SR88 = [3, 1, 5, 0.5, 1.54, 1.5, 0.8, 2, 0.67, 1.17, 0.51,
    0.5, 0.61, 6.7, 4, 7, 19, 0.2, 5, 3.83]

# calculate change:
Change = SR88 .- SR87

# ingredients to CI formula:
avgCh = mean(Change)
println("avgCh = $avgCh\n")

n = length(Change)
sdCh = std(Change)
se = sdCh / sqrt(n)
println("se = $se\n")

c = quantile(TDist(n - 1), 0.975)
println("c = $c\n")

# confidence interval:
lowerCI = avgCh - c * se
println("lowerCI = $lowerCI\n")
upperCI = avgCh + c * se
println("upperCI = $upperCI")