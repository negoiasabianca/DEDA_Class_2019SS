[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **optimal_weights_CVaR** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet:  optimal_weights_CVaR

Published in:      'DEDA Class'

Description:       'Determining which the optimal portfolio weights are and what CVaR they result into'

Keywords:          optimal weights, minimal CVaR

Author:            Georg Velev, Iliyana Pekova

Submitted:         Thu, August 01 2019 by Georg Velev, Iliyana Pekova

Output:            'optimal_weights_CVaR in .PNG format'

```

### MATLAB Code
```matlab

[row,col] = find(mat==min(mat(:,5)))
mat(row,col)
mat(row,:)

```

automatically created on 2019-08-01