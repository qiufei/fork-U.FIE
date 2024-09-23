using WooldridgeDatasets, DataFrames, GLM, Plots, Statistics

ceosal1 = DataFrame(wooldridge("ceosal1"))

# usual OLS regression:
reg1 = lm(@formula(salary ~ roe), ceosal1)
b1 = coef(reg1)
println("b1 = $b1\n")

# regression without intercept (through origin):
reg2 = lm(@formula(salary ~ 0 + roe), ceosal1)
b2 = coef(reg2)
println("b2 = $b2\n")

# regression without slope (on a constant):
reg3 = lm(@formula(salary ~ 1), ceosal1)
b3 = coef(reg3)
println("b3 = $b3\n")

# average y:
sal_mean = mean(ceosal1.salary)
println("sal_mean = $sal_mean")

# scatter plot and fitted values: 
scatter(ceosal1.roe, ceosal1.salary, color="grey85", label="observations")
plot!(ceosal1.roe, predict(reg1), linewidth=2,
    color="black", label="full")
plot!(ceosal1.roe, predict(reg2), linewidth=2,
    color="dimgrey", label="trough origin")
plot!(ceosal1.roe, predict(reg3), linewidth=2,
    color="lightgrey", label="const only")
xlabel!("roe")
ylabel!("salary")
savefig("JlGraphs/SLR-Origin-Const.pdf")