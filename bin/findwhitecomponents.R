#!/bin/Rscript

# just as the title says, we find the white components and enumerate them.
# we consider points with z==0 to be "solid", i.e. points in the set.
# where points with z==1 are "hollow", i.e. points are not in the set
# for which we are taking inventory of the components

# note this is the dual to findcomponents.R

# functions
dist<-function(x,y){return(sqrt(sum((x-y)^2)))}

library(plyr)
rep.row <- function(r, n){
  colwise(function(x) rep(x, n))(r)
}
###############

## given CC

N<-nrow(CC)
label<-rep(0,N)
distbin<-rep(0,N)
used<-rep(0,N)
CC<-cbind(CC,label,distbin,used)



pass=1
component=1

CC$label[1]=component


X<-CC[1,]

while(sum(CC$used)<(N-1)){

	

	CC$distbin<-sqrt(rowSums((CC[,1:2]-(rep.row(X[,1:2],N)))^2))	

	CC$label[CC$distbin==1]=X$label
    
    CC$used[which(CC$x==X$x&CC$y==X$y)]=1
	
    if(nrow(head(CC[CC$used==0&CC$label==X$label,],1))!=0){
    X<-head(CC[CC$used==0&CC$label==X$label,],1)
    }else{
    X<-head(CC[CC$used==0,],1)
    component=component+1
    X$label=component
    }


print(pass)
pass=pass+1
}

COMP=length(unique(A$label))

string<-sprintf("There are %d components", COMP)

print(string)








