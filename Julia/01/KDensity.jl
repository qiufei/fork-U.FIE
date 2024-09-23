using WooldridgeDatasets, DataFrames, Plots, KernelDensity

ceosal1 = DataFrame(wooldridge("ceosal1"))

# extract roe:
roe = ceosal1.roe

# estimate kernel density:
kde_est = KernelDensity.kde(roe)

# kernel density (a):
plot(kde_est.x, kde_est.density, color=:black, linewidth=2, legend=false)
ylabel!("density")
xlabel!("roe")
savefig("JlGraphs/Density1.pdf")

# kernel density with overlayed histogram (b):
histogram(roe, color="grey", normalize=true, legend=false)
plot!(kde_est.x, kde_est.density, color=:black, linewidth=2)
ylabel!("density")
xlabel!("roe")
savefig("JlGraphs/Density2.pdf")