#!/bin/Rscript

# qr codes appear in 25, 41, and 57 ^2 schemes
# for simplicity we'll start with 25^2


x<-rep(0, 25^2)
y<-rep(0, 25^2)
z<-rep(0, 25^2)

df<-data.frame(x,y)

N=25

i=1
I=1

while(i<=25){

	NN=25
	j=1
	while(j<=NN){
		df[I,1]=i
		df[I,2]=j
		df[I,3]=sample(c(0,1),1,replace=FALSE,prob=NULL)
		I=I+1
		j=j+1
	}

print(i)
i=i+1
}

save(df,file="./var/df")
rm(list=ls())	
