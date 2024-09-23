using DataFrames, CategoricalArrays, Statistics

# define a DataFrame:
icecream_sales = [30, 40, 35, 130, 120, 60]
weather_coded = [0, 1, 0, 1, 1, 0]
customers = [2000, 2100, 1500, 8000, 7200, 2000]
df = DataFrame(
    icecream_sales=icecream_sales,
    weather_coded=weather_coded,
    customers=customers
)

# get some descriptive statistics:
descr_stats = describe(df)
println("descr_stats: \n$descr_stats\n")

# add one observation at the end in-place:
push!(df, [50, 1, 3000])
println("df: \n$df\n")

# extract observations with more than 2500 customers:
subset_df = subset(df, :customers => ByRow(>(2500)))
println("subset_df: \n$subset_df\n")

# use a CategoricalArray object to attach labels (0 = bad; 1 = good):
df.weather = recode(df[!, :weather_coded], 0 => "bad", 1 => "good")
println("df \n$df\n")

# mean sales for each weather category by
# grouping and splitting data:
grouped_data = groupby(df, :weather)
# apply the mean to icecream_sales and combine the results:
group_means = combine(grouped_data, :icecream_sales => mean)
println("group_means: \n$group_means")