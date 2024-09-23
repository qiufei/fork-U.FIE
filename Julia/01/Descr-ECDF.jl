using WooldridgeDatasets, DataFrames, Plots

ceosal1 = DataFrame(wooldridge("ceosal1"))

# extract roe:
roe = ceosal1.roe

# calculate ECDF:
x = sort(roe)
n = length(x)
y = range(start=1, stop=n) / n

# plot a step function:
plot(x, y, linetype=:steppre, color=:black, legend=false)
xlabel!("roe")
savefig("JlGraphs/ecdf.pdf")