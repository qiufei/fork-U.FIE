using Distributions

q_975 = quantile(Normal(), 0.975)
println("q_975 = $q_975")