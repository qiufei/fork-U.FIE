using Distributions, Random, HypothesisTests

# set the random seed:
Random.seed!(12345)

# set sample size and MC simulations:
r = 10000
n = 100

# initialize arrays to later store results:
CIlower = zeros(r)
CIupper = zeros(r)
pvalue1 = zeros(r)
pvalue2 = zeros(r)


# repeat r times:
for j in 1:r
    # draw a sample
    sample = rand(Normal(10, 2), n)
    sample_mean = mean(sample)
    sample_sd = std(sample)

    # test the (correct) null hypothesis mu=10:
    testres1 = OneSampleTTest(sample, 10)
    pvalue1[j] = pvalue(testres1)
    cv = quantile(TDist(n - 1), 0.975)
    CIlower[j] = sample_mean - cv * sample_sd / sqrt(n)
    CIupper[j] = sample_mean + cv * sample_sd / sqrt(n)

    # test the (incorrect) null hypothesis mu=9.5 & store the p value:
    testres2 = OneSampleTTest(sample, 9.5)
    pvalue2[j] = pvalue(testres2)

end

# test results as logical value:
reject1 = pvalue1 .<= 0.05
count1_true = count(reject1) # counts true
count1_false = r - count1_true
println("count1_true: $count1_true\n")
println("count1_false: $count1_false\n")

reject2 = pvalue2 .<= 0.05
count2_true = count(reject2)
count2_false = r - count2_true
println("count2_true: $count2_true\n")
println("count2_false: $count2_false")