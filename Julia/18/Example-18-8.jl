using WooldridgeDatasets, GLM, DataFrames, Statistics, Plots

phillips = DataFrame(wooldridge("phillips"))

# estimate models:
yt96 = subset(phillips, :year => ByRow(<=(1996)))
reg_1 = lm(@formula(unem ~ unem_1), yt96)
reg_2 = lm(@formula(unem ~ unem_1 + inf_1), yt96)

# predictions for 1997-2003:
yf97 = subset(phillips, :year => ByRow(>(1996)))
pred_1 = round.(predict(reg_1, yf97), digits=5)
println("pred_1 = $pred_1\n")
pred_2 = round.(predict(reg_2, yf97), digits=5)
println("pred_2 = $pred_2\n")

# forecast errors:
e1 = yf97.unem .- pred_1
e2 = yf97.unem .- pred_2

# RMSE and MAE:
rmse1 = sqrt(mean(e1 .^ 2))
println("rmse1 = $rmse1\n")

rmse2 = sqrt(mean(e2 .^ 2))
println("rmse2 = $rmse2\n")

mae1 = mean(abs.(e1))
println("mae1 = $mae1\n")

mae2 = mean(abs.(e2))
println("mae2 = $mae2")

# graph:
plot(yf97.year, yf97.unem, color="black", linewidth=2,
    linestyle=:solid, label="unem", legend=:topleft)
plot!(yf97.year, pred_1, color="black", linewidth=2,
    linestyle=:dash, label="forecast without inflation")
plot!(yf97.year, pred_2, color="black", linewidth=2,
    linestyle=:dashdot, label="forecast with inflation")
ylabel!("unemployment")
xlabel!("time")
savefig("JlGraphs/Example-18-8.pdf")