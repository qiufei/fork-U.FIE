using WooldridgeDatasets, DataFrames, GLM, Plots

vote1 = DataFrame(wooldridge("vote1"))

# OLS regression:
reg = lm(@formula(voteA ~ shareA), vote1)
b = coef(reg)
println("b = $b")

# scatter plot and fitted values:
fitted_values = predict(reg)
scatter(vote1.shareA, vote1.voteA,
    color=:grey, label="observations", legend=:topleft)
plot!(vote1.shareA, fitted_values, color=:black, linewidth=3, label="OLS")
xlabel!("shareA")
ylabel!("voteA")
savefig("JlGraphs/Example-2-5.pdf")