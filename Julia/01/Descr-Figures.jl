using WooldridgeDatasets, DataFrames, Plots, StatsPlots,
    FreqTables, CategoricalArrays

affairs = DataFrame(wooldridge("affairs"))

# attach labels to kids and convert it to a categorical variable:
affairs.haskids = categorical(
    recode(affairs.kids, 0 => "no", 1 => "yes")
)

# ... and ratemarr (for example: 1 = "very unhappy", 2 = "unhappy",...):
affairs.marriage = categorical(
    recode(affairs.ratemarr,
        1 => "very unhappy",
        2 => "unhappy",
        3 => "average",
        4 => "happy",
        5 => "very happy"
    )
)

# counts for all graphs:
counts_m = sort(freqtable(affairs.marriage), rev=true)
levels_counts_m = String.(collect(keys(counts_m.dicts[1])))
colors_m = [:grey60, :grey50, :grey40, :grey30, :grey20]

ct_all_abs = freqtable(affairs.marriage, affairs.haskids)
levels_counts_all = String.(collect(keys(ct_all_abs.dicts[1])))
colors_all = [:grey80 :grey50]

# pie chart (a):
pie(levels_counts_m, counts_m, color=colors_m)
savefig("JlGraphs/Descr-Pie.pdf")

# bar chart (b):
bar(levels_counts_m, counts_m, color=:grey, legend=false)
savefig("JlGraphs/Descr-Bar1.pdf")

# stacked bar plot (c):
groupedbar(ct_all_abs, bar_position=:stack,
    color=colors_all, label=["no" "yes"])
xticks!(1:5, levels_counts_all)
savefig("JlGraphs/Descr-Bar2.pdf")

# grouped bar plot (d):
groupedbar(ct_all_abs, bar_position=:dodge,
    color=colors_all, label=["no" "yes"])
xticks!(1:5, levels_counts_all)
savefig("JlGraphs/Descr-Bar3.pdf")