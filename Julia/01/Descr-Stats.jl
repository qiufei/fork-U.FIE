using WooldridgeDatasets, DataFrames, Statistics

ceosal1 = DataFrame(wooldridge("ceosal1"))

# extract roe and salary:
roe = ceosal1.roe
salary = ceosal1.salary

# sample average:
roe_mean = mean(roe)
println("roe_mean = $roe_mean\n")

# sample median:
roe_med = median(roe)
println("roe_med = $roe_med\n")

# corrected standard deviation (n-1 scaling):
roe_std = std(roe)
println("roe_st = $roe_std\n")

# correlation with roe:
roe_corr = cor(roe, salary)
println("roe_corr = $roe_corr\n")

# correlation matrix with roe:
roe_corr_mat = cor(hcat(roe, salary))
println("roe_corr_mat: \n$roe_corr_mat")