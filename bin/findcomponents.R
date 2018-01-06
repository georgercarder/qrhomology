#!/bin/Rscript

# just as the title says, we find the components and enumerate them.
# we consider points with z==1 to be "solid", i.e. points in the set.
# where points with z==0 are "hollow", i.e. points are not in the set
# for which we are taking inventory of the components

# functions
dist<-function(x,y){return(sqrt(sum((x-y)^2)))}

library(plyr)
rep.row <- function(r, n){
  colwise(function(x) rep(x, n))(r)
}
###############

load("./var/df")

# first we collect all points in the set

A<-df[df[,3]==1,]

label<-rep(0,nrow(A))
distbin<-rep(0,nrow(A))
used<-rep(0,nrow(A))
A<-cbind(A,label,distbin,used)

N<-nrow(A)
i=1
pass=1
component=1
found=0
exhaustfind=0
A$label[1]=component


X<-A[1,]

while(sum(A$used)<(N-1)){

	

	A$distbin<-sqrt(rowSums((A[,1:2]-(rep.row(X[,1:2],N)))^2))	

	A$label[A$distbin<=sqrt(2)]=X$label
    
    A$used[which(A$x==X$x&A$y==X$y)]=1
	
    if(nrow(head(A[A$used==0&A$label==X$label,],1))!=0){
    X<-head(A[A$used==0&A$label==X$label,],1)
    }else{
    X<-head(A[A$used==0,],1)
    component=component+1
    X$label=component
    }


print(pass)
pass=pass+1
}

COMP=length(unique(A$label))

string<-sprintf("There are %d components", COMP)

print(string)

save(A,file="./var/A")
rm(list=ls())







