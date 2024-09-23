using DataFrames

# define a DataFrame:
icecream_sales = [30, 40, 35, 130, 120, 60]
weather_coded = [0, 1, 0, 1, 1, 0]
customers = [2000, 2100, 1500, 8000, 7200, 2000]
df = DataFrame(
    icecream_sales=icecream_sales,
    weather_coded=weather_coded,
    customers=customers
)

# print the DataFrame
println("df: \n$df\n")

# access columns by variable reference:
subset1 = df[!, [:icecream_sales, :customers]]
println("subset1: \n$subset1\n")

# access second to fourth row:
subset2 = df[2:4, :]
println("subset2: \n$subset2\n")

# access rows and columns by variable integer positions:
subset3 = df[2:4, 1:2]
println("subset3: \n$subset3\n")

# access rows by variable integer positions:
subset4 = df[2:4, [:icecream_sales, :weather_coded]]
println("subset4: \n$subset4")