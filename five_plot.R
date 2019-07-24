rm(list=ls())
library(readxl)
library(tseries)
library(devtools)
library(FinTS)
eos=read.table("C:\\Users\\76783\\Desktop\\CRIX\\EOS.txt",header=T)
btc=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BTC.txt",header=T)
eth=read.table("C:\\Users\\76783\\Desktop\\CRIX\\ETH.txt",header=T)
xrp=read.table("C:\\Users\\76783\\Desktop\\CRIX\\XRP.txt",header=T)
bch=read.table("C:\\Users\\76783\\Desktop\\CRIX\\BCH.txt",header=T)

eos_price<-eos$price
btc_price<-btc$price
eth_price<-eth$price
xrp_price<-xrp$price
bch_price<-bch$price
L<-c(length(eos_price),length(btc_price),length(eth_price),length(xrp_price),length(bch_price))
L

eos_date<-as.Date(eos$date)
btc_date<-as.Date(btc$date)
eth_date<-as.Date(eth$date)
xrp_date<-as.Date(xrp$date)
bch_date<-as.Date(bch$date)

eos_price<-log(eos$price)
btc_price<-log(btc$price)
eth_price<-log(eth$price)
xrp_price<-log(xrp$price)
bch_price<-log(bch$price)
#
png("Sive_Plot.png", width=20, height=15, units="cm", res=800, bg="transparent")
#par(mfcol=c(3,2))
#par(mai=c(2,0.5,0.5,0.5))
plot(eth_date,eth_price,type='l',col="black",xlab="date",ylab="",ylim=c(-2,15))
lines(bch_date,bch_price,lty= 1,pch=19,col="red",xlab="date",ylab="")
lines(btc_date,btc_price,lty= 1,col="blue",xlab="date",ylab="")
lines(eos_date,eos_price,lty= 1,col="purple",xlab="date",ylab="")
lines(xrp_date,xrp_price,lty= 1,col="yellow",xlab="date",ylab="")
legend( "topright",c("eth", "bch", "btc","eos","xrp"), 
      text.col = c("black","red","blue","purple","yellow"), lty = c(1, 1, 1,1,1),col=c("black","red","blue","purple","yellow"),merge = TRUE, bg = "gray95",xpd=TRUE)
dev.off()



