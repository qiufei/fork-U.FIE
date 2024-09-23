using WooldridgeDatasets, DataFrames, Dates, Plots

barium = DataFrame(wooldridge("barium"))
T = nrow(barium)

# monthly time series starting Feb. 1978:
barium.date = range(Date(1978, 2, 1), step=Month(1), length=T)
preview = barium[1:5, ["date", "chnimp"]]
println("preview: \n$preview")

# plot chnimp:
plot(barium.date, barium.chnimp, legend=false, color="grey")
ylabel!("chnimp")
savefig("JlGraphs/Example-Barium.pdf")