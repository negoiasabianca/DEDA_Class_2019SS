[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

```yaml
Name of QuantLet: Plot_CVaR_for_different_initial_Weights

Published in: 'DEDA Class'

Description: 'Plotting the CVaR for all sets of different initial weights'

Keywords: plot, CVaR, all sets of initial weights

Author: Georg Velev, Iliyana Pekova

Submitted: Thu, August 01 2019 by Georg Velev, Iliyana Pekova

Output: 'plot in .PNG format'
```

![Picture1](plot.PNG)


### MATLAB code
```matlab
%plot as time  series (minimum easy to see, however no convergence)
load count.dat
count1 = timeseries(mat(:,5),1:9);
count1.Name = 'CVaR Value';
count1.TimeInfo.Units = 'Iterations';
plot(count1,':b')
grid on
```
