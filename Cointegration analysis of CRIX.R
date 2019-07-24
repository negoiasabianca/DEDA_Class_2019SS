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
library(MTS)
library(vars)
eos=read.table("C:\\Users\\76783\\Desktop\\CRIX\\EOS.txt",header=T)
btc=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BTC.txt",header=T)
eth=read.table("C:\\Users\\76783\\Desktop\\CRIX\\ETH.txt",header=T)
xrp=read.table("C:\\Users\\76783\\Desktop\\CRIX\\XRP.txt",header=T)
bch=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BCH.txt",header=T)

btc_price<-btc$price
eos_price<-eos$price
eth_price<-eth$price
xrp_price<-xrp$price
bch_price<-bch$price

L<-c(length(eos_price),length(btc_price),length(eth_price),length(xrp_price),length(bch_price))
logprice<-rbind(log(rbind(eos_price,eth_price,bch_price,btc_price)),xrp_price)
logprice<-t(logprice)

model20<-ca.jo(logprice, ecdet = "none", type="eigen", K=2,spec="longrun")
summary(model20)

end<-ncol(logprice)
dlogprice<-logprice[,2:end]-logprice[,1:(end-1)]#Delta_X_t
#constant
VARselect(as.data.frame(t(logprice)),lag.max=10,type=c("const"))  #AIC:p=2
?VAR

Z_0t<-dlogprice
Z_1t<-logprice[,-end]
constant<-rep(1,end-1)
Z_2t_1<-cbind(logprice[,1],dlogprice[,-ncol(dlogprice)])#delta_x_t-1

#Z_2t_2<-cbind(0,logprice[,1],dlogprice[,-c(ncol(dlogprice)-1,ncol(dlogprice))])#delta_x_t_2
#Z_2t_3<-cbind(0,0,logprice[,1],dlogprice[,-c(ncol(dlogprice)-2,ncol(dlogprice)-1,ncol(dlogprice))])#delta_x_t_3
#Z_2t_4<-cbind(0,0,0,logprice[,1],dlogprice[,-c(ncol(dlogprice)-3,ncol(dlogprice)-2,ncol(dlogprice)-1,ncol(dlogprice))])#delta_x_t_2

Z_2t<-rbind(Z_2t_1)
#Z_2t<-rbind(Z_2t_1,Z_2t_2,constant)
#Z_2t<-rbind(Z_2t_1,Z_2t_2,Z_2t_3,Z_2t_4,constant)
#Z_2t<-rbind(cbind(logprice[,1],dlogprice[,-ncol(dlogprice)]),constant)#Delta_X_t-1

M_02<-Z_0t%*%t(Z_2t)/(end-1)
M_12<-Z_1t%*%t(Z_2t)/(end-1)
M_22<-Z_2t%*%t(Z_2t)/(end-1)

R_0t<-Z_0t-M_02%*%solve(M_22)%*%Z_2t
R_1t<-Z_1t-M_12%*%solve(M_22)%*%Z_2t

S_00<-R_0t%*%t(R_0t)/(end-1)
S_01<-R_0t%*%t(R_1t)/(end-1)
S_11<-R_1t%*%t(R_1t)/(end-1)

E<-eigen(solve(S_11)%*%t(S_01)%*%solve(S_00)%*%S_01)
E$values
# 0.0710223255 0.0441172212 0.0225315479 0.0156779232 0.0005966556
#beta=cbind(matrix(E$vectors[,1],5,1),matrix(E$vectors[,2],5,1))
beta=matrix(E$vectors[,1],5,1)
# 0.14179574 -0.02173353 -0.21600397  0.08697881  0.96187244
##2019.0717  ECMvar()
logprice<-as.data.frame(t(logprice)) 
beta=matrix(E$vectors[,1],5,1)
n3<-ECMvar(logprice,2,ibeta = beta,include.const = FALSE)
n3a<-refECMvar(n3,thres=0.5)
MTSdiag(n3a)
alpha<-n3a$alpha
Gamma<-n3a$Phip
#long-run relationship
longrun<-as.vector(t(beta)%*%as.matrix(logprice[,-end]))
adfTest(longrun,lags=12) #p-value<0.01, one cointegration
kpss.test(longrun)

#
png("acf_longrun.png", width=20, height=15, units="cm", res=800, bg="transparent")
acf(longrun)
dev.off()
#
date<-as.Date(btc$date)[-end]
png("longrun4.png", width=20, height=15, units="cm", res=800, bg="transparent")
plot(date,longrun,type='l',col="black",xlab="date",ylab="",ylim=c(-0.5,0.5),main="Time plot of cointegrated series")
dev.off()

#level VAR(2)
A_1<-alpha%*%t(beta)+diag(1,5)+Gamma
A_2<--Gamma
#Impluse Response Function
Phi_1<-A_1
Phi_2<-A_1%*%A_1+A_2 
Phi_3<-Phi_2%*%A_1+Phi_1%*%A_2 
Phi_4<-Phi_3%*%A_1+Phi_2%*%A_2 
Phi_5<-Phi_4%*%A_1+Phi_3%*%A_2 
Phi_6<-Phi_5%*%A_1+Phi_4%*%A_2 
Phi_7<-Phi_6%*%A_1+Phi_5%*%A_2 
#figure of IRF
namea<-matrix(c("eos-eos","eos-eth","eos-bch","eos-btc","eos-xrp","eth-eos","eth-eth","eth-bch","eth-btc","eth-xrp","bch-eos",
                "bch-eth","bch-bch","bch-btc","bch-xrp","btc-eos","btc-eth","btc-bch","btc-btc","btc-xrp","xrp-eos","xrp-eth"
                ,"xrp-bch","xrp-btc","xrp-xrp"),5,5)
namea<-t(namea)
png("IRF.png", width=40, height=40, units="cm", res=800, bg="transparent")
par(mfrow=c(5,5))
for(i in 1:5){
  for(j in 1:5){
    plot_y<-c(Phi_1[i,j],Phi_2[i,j],Phi_3[i,j],Phi_4[i,j],Phi_5[i,j],Phi_6[i,j])
    x<-c(1:6)
    plot(x,plot_y,type='l',col='blue',xlab='',ylab='')
    title(main = namea[i,j])
  }
}
dev.off()

