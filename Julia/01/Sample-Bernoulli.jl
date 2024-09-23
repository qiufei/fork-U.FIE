using Distributions

sample = rand(Bernoulli(0.5), 10)
println("sample: $sample")