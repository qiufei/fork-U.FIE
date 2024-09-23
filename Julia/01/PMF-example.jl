using Distributions, DataFrames, Plots

# PMF for all values between 0 and 10:
x = 0:10
fx = pdf.(Binomial(10, 0.2), x)

# collect values in DataFrame:
result = DataFrame(x=x, fx=fx)
println("result: \n$result")

# plot:
bar(x, fx, color=:grey, alpha=0.6, legend=false)
xlabel!("x")
ylabel!("fx")
savefig("JlGraphs/PMF-example.pdf")