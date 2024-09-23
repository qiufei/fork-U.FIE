import yfinance as yf

# download data for 'F' (= Ford Motor Company) and define start and end:
tickers = ['F']
start_date = '2014-01-01'
end_date = '2015-12-31'

# use yfinance for the import:
F_data = yf.download(tickers, start_date, end_date)

# look at imported data:
print(f'F_data.head(): \n{F_data.head()}\n')
print(f'F_data.tail(): \n{F_data.tail()}\n')