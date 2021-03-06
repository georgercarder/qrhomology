#!/bin/Rscript

# we have generated qr code with demoqr
# we have labelled and counted components with findcomponents
# now we find the generators of the homology groups


# NEED TO WORK OUT WHAT HAPPENS AT BOUNDARY

# functions

library(plyr)
rep.row <- function(r, n){
  colwise(function(x) rep(x, n))(r)
}

load("./var/A")
load("./var/df")

n<-length(unique(A$label))
z<-rep(0,nrow(df))

LOOPS=0
if(0 %in% unique(A$label)){
  i=0
}else{
  i=1
n=n+1
}

while(i<n){

  B<-A[A$label==i,]
  maxx<-max(B$x)
  maxy<-max(B$y)
  minx<-min(B$x)
  miny<-min(B$y)

  C<-cbind(df[,1:2],z)
  ii=1
  nn<-nrow(B)
  while(ii<=nn){
    C$z[which(C$x==B$x[i]&C$y==B$y[i])]=1
  ii=ii+1
  }


  ## here we find number of z=0 components.. i.e. complement to black object

    CC<-C[C$z==0&(C$x %in% (minx-1):(maxx+1))&(C$y %in% (miny-1):(miny+1)),]


      ## input is CC
      source("./bin/findwhitecomponents.R")
      ## output is COMP
    

  ##
  LOOPS=LOOPS+(COMP-1)


print(i)
i=i+1
}

string<-sprintf("There are %d loops", LOOPS)

print(string)


