using Distributions

sample = rand(Normal(), 6)
sample_rounded = round.(sample, digits=5)
println("sample_rounded: $sample_rounded")