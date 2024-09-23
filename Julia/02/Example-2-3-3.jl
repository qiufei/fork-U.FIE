using WooldridgeDatasets, DataFrames, GLM, Plots

ceosal1 = DataFrame(wooldridge("ceosal1"))

reg = lm(@formula(salary ~ roe), ceosal1)

# scatter plot and fitted values:
fitted_values = predict(reg)
scatter(ceosal1.roe, ceosal1.salary, color=:grey80, label="observations")
plot!(ceosal1.roe, fitted_values, color=:black, linewidth=3, label="OLS")
xlabel!("roe")
ylabel!("salary")
savefig("JlGraphs/Example-2-3-3.pdf")

# instead of scatter, you can also use:
# plot(ceosal1.roe, ceosal1.salary, label="observations", seriestype=:scatter)