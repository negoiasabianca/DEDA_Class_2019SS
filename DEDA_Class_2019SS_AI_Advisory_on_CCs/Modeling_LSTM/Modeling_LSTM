from keras.callbacks import EarlyStopping

def train_predict_evaluate(params,data,train_test_split):
  rmse=[]
  for i in range(0,len(params)):
    print("This is iteration ",(i+1)," from ",len(params), " iterations.")
    parameters=params[i]
    X_train, y_train, X_test, y_test=generate_Xtrain_yTrain_Xtest_Ytest(data,train_test_split,24,24) 
    model_LSTM=multi_step_LSTM(n_steps_in=24, n_features=1,n_steps_out=24,nr_neurons=parameters['number_neurons'],epochs=parameters["epochs"],lr=parameters["learning_rate"])
    early_stop=EarlyStopping(monitor='loss', mode='min', verbose=0, patience=10, restore_best_weights=True)
    model_LSTM.fit(X_train, y_train, batch_size=parameters["batch_size"],epochs=parameters["epochs"],verbose=0,callbacks=[early_stop])
    rmse_result=model_LSTM.evaluate(X_test, y_test, verbose=0)
    print("Total RMSE from iteration ", (i+1), " is equal to ",rmse_result,".","\n")
    rmse.append(rmse_result)
 
  new_data=pd.DataFrame({"RMSE": rmse,"Parameters": params}, columns=["RMSE","Parameters"])
  new_data=new_data.sort_values(by='RMSE', ascending=True)
  return new_data 


from sklearn.model_selection import ParameterGrid

param_grid_LSTM = {
  'batch_size': [16,32],
  'epochs': [30,60],
  'number_neurons': [100,150],
   'learning_rate': [0.05,0.01]
   }

params=list(ParameterGrid(param_grid_LSTM))

results_ETH=train_predict_evaluate(params,ETH,0.8)

print("Minimal RMSE achieved: ",round(results_ETH.iloc[0,0],5))
print("Corresponding parameters: ",results_ETH.iloc[0,1])
