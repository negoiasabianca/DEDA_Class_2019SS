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


eos=read.table("C:\\Users\\76783\\Desktop\\CRIX\\EOS.txt",header=T)
btc=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BTC.txt",header=T)
eth=read.table("C:\\Users\\76783\\Desktop\\CRIX\\ETH.txt",header=T)
xrp=read.table("C:\\Users\\76783\\Desktop\\CRIX\\XRP.txt",header=T)
bch=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BCH.txt",header=T)

btc_price<-diff(log(btc$price),2)
eos_price<-eos$price[-c(1,2)]
eth_price<-eth$price[-c(1,2)]
xrp_price<-xrp$price[-c(1,2)]
bch_price<-bch$price[-c(1,2)]
L<-c(length(eos_price),length(btc_price),length(eth_price),length(xrp_price),length(bch_price))
logprice<-rbind(log(rbind(eos_price,eth_price,bch_price)),xrp_price,btc_price)#
#logprice<-logprice[,-c(1:289)]
end<-ncol(logprice)
dlogprice<-logprice[,2:end]-logprice[,1:(end-1)]

S_11<-logprice[,-end]%*%t(logprice[,-end])
S_00<-dlogprice%*%t(dlogprice)
S_01<-dlogprice%*%t(logprice[,-end])
#E<-eigen(S_01%*%solve(S_11)%*%t(S_01)%*%solve(S_00))

E<-eigen(solve(S_11)%*%t(S_01)%*%solve(S_00)%*%S_01)
E$values

beta=matrix(E$vectors[,1],5,1)
alpha<-S_01%*%beta%*%solve(t(beta)%*%S_01%*%beta)
alpha%*%t(beta)
longrun<-t(beta)%*%as.matrix(logprice[,-end])
adfTest(longrun,lags=12)     #p-value<0.01
#
epsilon_t<-dlogprice-alpha%*%t(beta)%*%as.matrix(logprice[,-end])
Gamma_z<-longrun%*%t(longrun)/end
Sigma_u<-epsilon_t%*%t(epsilon_t)/end
#Sigma_alpha<-as.matrix(Sigma_u)*solve(Gamma_z)
std<-sqrt(as.vector(diag(Sigma_u))*solve(Gamma_z)/end)
as.vector(alpha)/std

#0.62989937  0.65026242  0.63343424  1.34308267 -0.01570613
