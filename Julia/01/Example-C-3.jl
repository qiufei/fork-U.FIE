using WooldridgeDatasets, DataFrames, Distributions

audit = DataFrame(wooldridge("audit"))
y = audit.y

# ingredients to CI formula:
avgy = mean(y)
n = length(y)
sdy = std(y)
se = sdy / sqrt(n)
c95 = quantile(Normal(), 0.975)
c99 = quantile(Normal(), 0.995)

# 95% confidence interval:
lowerCI95 = avgy - c95 * se
println("lowerCI95 = $lowerCI95\n")

upperCI95 = avgy + c95 * se
println("upperCI95 = $upperCI95\n")

# 99% confidence interval:
lowerCI99 = avgy - c99 * se
println("lowerCI99 = $lowerCI99\n")

upperCI99 = avgy + c99 * se
println("upperCI99 = $upperCI99")