import numpy as np
#Spurce: https://machinelearningmastery.com/how-to-develop-lstm-models-for-time-series-forecasting/

# split a univariate sequence into samples
def split_sequence(sequence, n_steps_in, n_steps_out):
    X, y = list(), list()
    for i in range(len(sequence)):
        # find the end of this pattern
        end_ix = i + n_steps_in
        out_end_ix = end_ix + n_steps_out
        # check if we are beyond the sequence
        if out_end_ix > len(sequence):
            break
		# gather input and output parts of the pattern
        seq_x, seq_y = sequence[i:end_ix], sequence[end_ix:out_end_ix]
        X.append(seq_x)
        y.append(seq_y)
    X=np.array(X)
    X=np.reshape(X, (X.shape[0],X.shape[1],1))
    y=np.array(y)
    return X, y
  
  
#Example Sequence:  
a=np.arange(17)

a_train=a[:int(len(a)*0.75)]
a_test=a[int(len(a)*0.75):]

print("Train Set before the Transformation:",a_train)
print("Test Set before the Transformation:",a_test,"\n")

X_train_a,y_train_a,X_test_a,y_test_a=generate_Xtrain_yTrain_Xtest_Ytest(a,0.75,3,2)

print("The shape of the Train Set after the Transformation:","(nr. observation,timesteps,nr. features)")
print("Shape Train Set:",X_train_a.shape,"\n")
for i in range(len(X_train_a)):
  print("Input: ")
  print(X_train_a[i])
  print("Output: ")
  print(y_train_a[i],"\n")
