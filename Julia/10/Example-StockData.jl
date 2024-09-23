using DataFrames, Dates, MarketData, Plots

# download data for "F" (= Ford Motor Company) and define start and end:
ticker = "F"
start_date = DateTime(2014, 1, 1)
end_date = DateTime(2016, 1, 1)

# import data:
F_data = yahoo(ticker, YahooOpt(period1=start_date, period2=end_date))

# look at imported data:
F_data_head = first(DataFrame(F_data), 5)
println("F_data_head: \n$F_data_head\n")

F_data_tail = last(DataFrame(F_data), 5)
println("F_data_tail: \n$F_data_tail")

# time series plot of adjusted closing prices:
plot(F_data.AdjClose, legend=false, color="grey")
ylabel!("AdjClose")
savefig("JlGraphs/Example-StockData.pdf")