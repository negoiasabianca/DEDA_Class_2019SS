#Custom Imports
import requests, pandas as pd, time, datetime, numpy import array, numpy as np

#Source: https://blog.cryptocompare.com/cryptocompare-api-quick-start-guide-f7abbd20d260
    
#This function establishes a request to the online plattform BitFinex:
def get_data_spec(coin, date, time_period):
    """ Query the API for the historical price data starting from "date". """
    url = "https://min-api.cryptocompare.com/data/{}?fsym={}&e=BitFinex&tsym=USD&toTs={}".format(time_period, coin, date)
    r = requests.get(url)
    ipdata = r.json()
    return ipdata

#This function collects the cryptocurrency data from for the specified time period: 
def get_df_spec(time_period, coin, from_date, to_date):
    """ Get historical price data between two dates. If further apart than query limit then query multiple times. """
    date = to_date
    holder = []
    while date > from_date:
        # Now we use the new function to query specific coins
        data = get_data_spec(coin, date, time_period) 
        holder.append(pd.DataFrame(data["Data"]))
        
        date = data['TimeFrom'] 
    df = pd.concat(holder, axis = 0)
    df = df[df['time']>from_date]
    df['time'] = pd.to_datetime(df['time'], unit='s') 
    df.set_index('time', inplace=True)
    df.sort_index(ascending=False, inplace=True)
    return df

#This function generates the average hourly prices from the opening and the closing price and uses the new feture to 
#compute the hourly returns:
def compute_Hourly_Returns(data):
    data["Average_hourly_price"]=(data["close"]+data["open"])/2
    data["Hourly_returns"]=data["Average_hourly_price"].divide(data["Average_hourly_price"].shift())-1
    data= data.iloc[1:] 
    return data

#Set the start and the end date:
start_unix=time.mktime(datetime.datetime.strptime("30/03/2017", "%d/%m/%Y").timetuple())
end_unix=time.mktime(datetime.datetime.strptime("20/07/2019", "%d/%m/%Y").timetuple())

#Call the functions to retrieve the cryptocurrency data:
bitcoin=compute_Hourly_Returns(get_df_spec('histohour',"BTC", start_unix, end_unix))
ethereum=compute_Hourly_Returns(get_df_spec('histohour',"ETH", start_unix, end_unix))
litecoin=compute_Hourly_Returns(get_df_spec('histohour',"LTC", start_unix, end_unix))
dash=compute_Hourly_Returns(get_df_spec('histohour',"DASH", start_unix, end_unix))  

#Print overall information about the collected cryptocurrency data:
print("The variables contained in each of the datasets are the following: ")
print(bitcoin.columns,"\n")
print("The shape of the data: ","\n")
print("Each of datasets consists of: ",bitcoin.shape[1], " columns.", "\n")
print("Each of datasets consists of: ",bitcoin.shape[0], " rows.","\n")
print("The following overview shows the type of each feature in the datasets: ","\n")
print(bitcoin.info())
