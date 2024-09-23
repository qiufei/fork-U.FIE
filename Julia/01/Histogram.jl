using WooldridgeDatasets, Plots, DataFrames

ceosal1 = DataFrame(wooldridge("ceosal1"))

# extract roe:
roe = ceosal1.roe

# histogram with counts (a):
histogram(roe, color=:grey, legend=false)
ylabel!("Counts")
xlabel!("roe")
savefig("JlGraphs/Histogram1.pdf")

# histogram with density and explicit breaks (b):
breaks = [0, 5, 10, 20, 30, 60]
histogram(roe, color=:grey,
    bins=breaks,
    normalize=true,
    legend=false)
xlabel!("roe")
ylabel!("Density")
savefig("JlGraphs/Histogram2.pdf")