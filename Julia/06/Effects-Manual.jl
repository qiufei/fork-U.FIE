using WooldridgeDatasets, GLM, DataFrames, Plots, Statistics

hprice2 = DataFrame(wooldridge("hprice2"))

# repeating the regression from Example 6.2:
reg = lm(@formula(log(price) ~
        log(nox) + log(dist) + rooms + (rooms^2) + stratio), hprice2)

# predictions with rooms = 4-8, all others at the sample mean:
nox_mean = mean(hprice2.nox)
dist_mean = mean(hprice2.dist)
stratio_mean = mean(hprice2.stratio)
X = DataFrame(
    rooms=4:8,
    nox=nox_mean,
    dist=dist_mean,
    stratio=stratio_mean)
println("X: \n$X\n")

# calculate 95% confidence interval:
lpr_CI = predict(reg, X, interval=:confidence)
println("lpr_CI: \n$lpr_CI\n")

# plot:
plot(X.rooms, lpr_CI.prediction, color="black", label=false, legend=:topleft)
plot!(X.rooms, lpr_CI.upper, color="lightgrey", linestyle=:dash, label="upper CI")
plot!(X.rooms, lpr_CI.lower, color="darkgrey", linestyle=:dash, label="lower CI")
ylabel!("lprice")
xlabel!("rooms")
savefig("JlGraphs/Effects-Manual.pdf")