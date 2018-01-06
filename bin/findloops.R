#!/bin/Rscript

# we have generated qr code with demoqr
# we have labelled and counted components with findcomponents
# now we find the generators of the homology groups

# functions
dist<-function(x,y){return(sqrt(sum((x-y)^2)))}

library(plyr)
rep.row <- function(r, n){
  colwise(function(x) rep(x, n))(r)
}

load("./var/A")
load("./var/df")

n<-length(unique(A$label))
z<-rep(0,nrow(df))

LOOPS=0

i=0

while(i<n){

    B<-A[A$label==i,]

    C<-cbind(df[,1:2],z)

    C$z[which(C$x==B$x&C$y==B$y)]=1

    ## here we find number of z=0 components.. i.e. complement to black object

        CC<-C[C$z==0,]

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


