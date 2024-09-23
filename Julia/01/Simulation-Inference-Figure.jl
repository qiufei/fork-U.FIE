using Distributions, HypothesisTests, Plots, Random

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

##################
## correct H0 ##
##################
plot(legend=false, size=(300, 500)) # initialize plot and set figure ratio
ylims!((0, 101))
xlims!((9, 11))
vline!([10], linestyle=:dash, color=:black, linewidth=0.5)
ylabel!("Sample No.")

for j in 1:100
    if 10 > CIlower[j] && 10 < CIupper[j]
        plot!([CIlower[j], CIupper[j]], [j, j], linestyle=:solid, color=:grey)
    else
        plot!([CIlower[j], CIupper[j]], [j, j], linestyle=:solid, color=:black)
    end
end
savefig("JlGraphs/Simulation-Inference-Figure1.pdf")

##################
## incorrect H0 ##
##################
plot(legend=false, size=(300, 500)) # initialize plot and set figure ratio
ylims!((0, 101))
xlims!((9, 11))
vline!([9.5], linestyle=:dash, color=:black, linewidth=0.5)
ylabel!("Sample No.")

for j in 1:100
    if 9.5 > CIlower[j] && 9.5 < CIupper[j]
        plot!([CIlower[j], CIupper[j]], [j, j], linestyle=:solid, color=:grey)
    else
        plot!([CIlower[j], CIupper[j]], [j, j], linestyle=:solid, color=:black)
    end
end
savefig("JlGraphs/Simulation-Inference-Figure2.pdf")