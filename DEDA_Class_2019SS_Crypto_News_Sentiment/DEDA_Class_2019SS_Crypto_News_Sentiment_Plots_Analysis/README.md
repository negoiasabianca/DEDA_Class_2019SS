[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **DEDA_Class_2019SS_Crypto_News_Sentiment_Plots_Analysis** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: 'DEDA_Class_2019SS_Crypto_News_Sentiment_Plots_Analysis'

Published in: 'DEDA_Class_2019SS'

Description: 'Plotting modules to graph rolling-mean time series data
              taken from derived sentiment scores. These are plotted against
              BTC prices in USD for visualisation of the relationship. Basic
              correlation and Granger causation are calculated as well.'

Keywords: 'Plotting, Time Series, Cryptocurrency'

Author: 'Alex Truesdale'

Submitted: 'Wed. July 31 2019 by Alex Truesdale'

Datafiles: '- bbc_bitcoin_scored.csv,
            - cnn_bitcoin_scored.csv,
            - nyt_bitcoin_scored.csv,
            - reuters_bitcoin_scored.csv'

See also: '1) plots/*.png

           2) frequency_charts.py
           3) publications_price_charts.py
           4) textblob_sentiment_price_chart_analysis.py
           5) vader_sentiment_price_chart_analysis.py
           6) vader_textblob_compare.py

           7) DEDA_Class_2019SS_Crypto_News_Sentiment_Sentiment_Scoring'

```

### PYTHON Code
```python

"""Analysis base module containing data load-in / preparation methods."""

import pandas as pd
import numpy as np
import datetime
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
pd.options.mode.chained_assignment = None

class AnalysisBase(object):
    """Container for data to be loaded and prepared for charting modules."""

    def __init__(self):

        self.data_in = self.reader()
        self.bbc = self.data_in[0]
        self.cnn = self.data_in[1]
        self.nyt = self.data_in[2]
        self.reuters = self.data_in[3]
        self.btc = self.data_in[4]
        self.crix = self.data_in[5]

        self.date_data = self.date_range_determiner()
        self.start_point = self.date_data[0]
        self.end_point = self.date_data[1]
        self.raw_index_days = self.date_data[2]
        self.raw_index_months = self.date_data[3]

        self.date_range_slicer()
        self.vader_scaler()
        self.textblob_scaler()

    def reader(self):
        """Read-in function for data sets."""

        bbc = pd.read_csv('data/scored/bbc_bitcoin_scored.csv').drop(['Unnamed: 0'], axis=1)
        cnn = pd.read_csv('data/scored/cnn_bitcoin_scored.csv').drop(['Unnamed: 0'], axis=1)
        nyt = pd.read_csv('data/scored/nyt_bitcoin_scored.csv').drop(['Unnamed: 0'], axis=1)
        reuters = pd.read_csv('data/scored/reuters_bitcoin_scored.csv').drop(['Unnamed: 0'], axis=1)

        bbc['published'] = pd.to_datetime(bbc['published'], utc=True)
        cnn['published'] = pd.to_datetime(cnn['published'], utc=True)
        nyt['published'] = pd.to_datetime(nyt['published'], utc=True)
        reuters['published'] = pd.to_datetime(reuters['published'], utc=True)

        btc = pd.read_csv('data/external/BTC-USD.csv', header=None, index_col=0).fillna(method='ffill')
        btc.columns = ['price']
        btc.index.name = 'date'
        btc.index = pd.to_datetime(btc.index, utc=True)

        crix = pd.read_csv('data/external/crix.csv')
        crix['date'] = pd.to_datetime(crix['date'], utc=True)

        return (bbc, cnn, nyt, reuters, btc, crix)

    def date_range_determiner(self):
        """Define the date range of analysis."""

        bbc_latest = self.bbc['published'].max()
        cnn_latest = self.cnn['published'].max()
        nyt_latest = self.nyt['published'].max()
        reuters_latest = self.reuters['published'].max()

        btc_latest = self.btc.index.max()
        crix_latest = self.crix['date'].max()

        start_point = pd.to_datetime('2017-01-01 00:00:00', utc=True)
        end_point = min(bbc_latest, cnn_latest, nyt_latest, reuters_latest,
                        btc_latest, crix_latest)

        raw_index_days = pd.date_range(start=start_point, end=end_point, freq='D')
        raw_index_months = pd.date_range(start=start_point, end=end_point, freq='M')
        return (start_point, end_point, raw_index_days, raw_index_months)

    def date_range_slicer(self):
        """standardise date ranges among respective data sources."""

        self.bbc = self.bbc[(self.bbc['published'] > self.start_point) & (self.bbc['published'] < self.end_point)]
        self.cnn = self.cnn[(self.cnn['published'] > self.start_point) & (self.cnn['published'] < self.end_point)]
        self.nyt = self.nyt[(self.nyt['published'] > self.start_point) & (self.nyt['published'] < self.end_point)]
        self.reuters = self.reuters[(self.reuters['published'] > self.start_point) & (self.reuters['published'] < self.end_point)]

        self.btc = self.btc[(self.btc.index > self.start_point) & (self.btc.index < self.end_point)]
        self.crix = self.crix[(self.crix['date'] > self.start_point) & (self.crix['date'] < self.end_point)]

    def vader_scaler(self):
        """Scale VADER scores to 0-1 range."""

        reshaped = self.bbc['vader_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.bbc['vader_score'] = reshaped_scaled

        reshaped = self.cnn['vader_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.cnn['vader_score'] = reshaped_scaled

        reshaped = self.nyt['vader_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.nyt['vader_score'] = reshaped_scaled

        reshaped = self.reuters['vader_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.reuters['vader_score'] = reshaped_scaled

    def textblob_scaler(self):
        """Scale TextBlob scores to 0-1 range."""

        reshaped = self.bbc['textblob_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.bbc['textblob_score'] = reshaped_scaled

        reshaped = self.cnn['textblob_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.cnn['textblob_score'] = reshaped_scaled

        reshaped = self.nyt['textblob_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.nyt['textblob_score'] = reshaped_scaled

        reshaped = self.reuters['textblob_score'].values.reshape(-1, 1)
        reshaped_scaled = scaler.fit_transform(reshaped)
        self.reuters['textblob_score'] = reshaped_scaled

```

automatically created on 2019-08-01