using WooldridgeDatasets, DataFrames, StatsPlots

ceosal1 = DataFrame(wooldridge("ceosal1"))
# extract roe and salary:
roe = ceosal1.roe
consprod = ceosal1.consprod

# plotting descriptive statistics:
boxplot(roe, orientation=:h,
    linecolor=:black, color=:white, legend=false)
yticks!([1], [""])
ylabel!("roe")
savefig("JlGraphs/Boxplot1.pdf")

# plotting descriptive statistics (logical indexing):
roe_cp0 = roe[consprod.==0]
roe_cp1 = roe[consprod.==1]
boxplot([roe_cp0, roe_cp1], linecolor=:black,
    color=:white, legend=false)
xticks!([1, 2], ["consprod=0", "consprod=1"])
ylabel!("roe")
savefig("JlGraphs/Boxplot2.pdf")