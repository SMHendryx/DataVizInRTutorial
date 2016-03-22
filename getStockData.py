__author__ = 'seanhendryx'
#Get historical stock data (adjusted closing prices) from yahoo

import pandas_datareader.data as web
import time

def main():
    startDate = '2007/12/01'
    today = time.strftime("%Y/%m/%d")
    print (today)
    endDate = today
    print (endDate)
    data = getHistoricalCloses(['AAPL', 'MSFT', 'GOOG'], startDate, endDate)
    data.to_csv("historicalCloses", sep = '\t')




def getHistoricalCloses(companies, startDate, endDate):
    p = web.DataReader(companies, "yahoo", startDate, endDate)
    d = p.to_frame()['Adj Close'].reset_index()
    d.rename(columns={'minor': 'Ticker','Adj Close': 'Close'}, inplace = True)
    pivoted = d.pivot (index = 'Date', columns = 'Ticker')
    pivoted.columns = pivoted.columns.droplevel(0)
    return pivoted

# Main Function
if __name__ == '__main__':
    main()