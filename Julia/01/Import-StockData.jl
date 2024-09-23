using DataFrames, Dates, MarketData

# download data for "F" (= Ford) and define start and end:
ticker = "F"
start_date = DateTime(2007, 12, 31)
end_date = DateTime(2017, 01, 01)

# import data as DataFrame:
F_data = DataFrame(yahoo(ticker,
    YahooOpt(period1=start_date, period2=end_date)))

preview_F_data = first(F_data, 5)
println("preview_F_data: \n$preview_F_data")