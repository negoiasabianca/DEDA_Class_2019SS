rm(list=ls())
library(readxl)
library(forecast)
library(urca)
library(fUnitRoots)
library(tseries)
library(devtools)
library(FinTS)
library(fGarch)
library(rugarch)
btc=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BTC.txt",header=T)
btc_price<-btc$price
btc_date<-as.Date(btc$date)
btc<-as.data.frame(cbind(btc_price,btc_date))

png("graph_btc.png", width=20, height=15, units="cm", res=800, bg="transparent")#
plot(btc_date,btc_price,main = "BTC",xlab=" ",ylab="daily price ",type='l',col='blue')
dev.off()
plot(btc_date,btc_price,main = "BTC",xlab="date",ylab=" ",type='l',col='blue')

#
daily_return<-diff(log(btc_price),1)
png("btc_logreturn.png", width=20, height=15, units="cm", res=800, bg="transparent")#
plot(btc_date[-1],daily_return,type = 'l',pch=19, col='blue', main = "BTC",xlab=" ",ylab="log return")
dev.off()

png("btc_acf.png", width=20, height=15, units="cm", res=800, bg="transparent")#
par(mfcol=c(2,1))
acf(daily_return, main = "")
pacf(daily_return,main = "")
dev.off()
#
Box.test(daily_return,lag=12,type='Ljung')# p-value = 0.04979
#
adfTest(daily_return,lags=12)#p-value=0.01
kpss.test(daily_return, null = c("Trend"), lshort = TRUE)#p-value=0.06
#
m1=auto.arima(daily_return)#ARIMA(0,1,1)
m1
m3=arima(daily_return,order=c(0,1,1),include.mean=F) 
m3

#arima(x = daily_return, order = c(0, 1, 1), include.mean = F)
#Coefficients:
#        ma1
#      -0.9803
#s.e.   0.0119

#sigma^2 estimated as 0.001096:  log likelihood = 766.18,  aic = -1528.36
#








