[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

```yaml
Name of QuantLet: Export_Predictions_to_MATLAB

Published in: 'DEDA Class'

Description: 'Split the entire dataset in two parts. the first one consists of all observations without the last 24 ones.      
              It is used for the training process of LSTM with the optimal parameters. The second subset consists of the 
              last 24 observations used for the prediction of the hourly returns in the next 24 hours. Once the predictions 
              are generated for each of the coins, they are exported from python in order to be imported in MATLAB.'

Keywords: LSTM, predictions, export

Author: Georg Velev, Iliyana Pekova

Submitted: Thu, August 01 2019 by Georg Velev, Iliyana Pekova

Output: 'predictions_for_export in csv Format.'
```

### Python Code
```python
import numpy as np

def generate_predictions(data):
  split_data=data["Hourly_returns"].sort_index(ascending=True).iloc[:-24]
  X_train_data, y_train_data=split_sequence(split_data.values.astype('float32'), 24, 24)
  predict_data=data["Hourly_returns"].sort_index(ascending=True).iloc[-24:]
  LSTM_model_data=multi_step_LSTM(n_steps_in=24, n_features=1,n_steps_out=24,nr_neurons=100,lr=0.01,epochs=60)
  training_entire_data=LSTM_model_data.fit(X_train_data, y_train_data,verbose=0,epochs=60,batch_size=16)
  predictions_data=LSTM_model_data.predict(np.reshape(predict_data.values,(1,24,1)))
  return predictions_data


predictions_ETH=generate_predictions(ethereum)
predictions_LTC=generate_predictions(litecoin)
predictions_DASH=generate_predictions(dash)
predictions_BTC=generate_predictions(bitcoin)

predictions_for_export=pd.DataFrame({"LTC": predictions_LTC.flatten(),"BTC": predictions_BTC.flatten(),"ETH": predictions_ETH.flatten(),"DASH": predictions_DASH.flatten()}, columns=["LTC","BTC","ETH","DASH"])

from google.colab import files
predictions_for_export.to_csv("predictions_for_export.csv")
files.download("predictions_for_export.csv")
```
