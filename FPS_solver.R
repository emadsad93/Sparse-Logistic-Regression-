rm(list = ls()); 
library(fps); 
a = read.csv("M", header = FALSE); 
b = data.matrix(a); 
o = c(1e-04,  1e-03,  1e-02, 1e-01,  1e+00,  1e+01,  1e+02,  1e+03, 1e+04, 1e+05); 
out <- fps(b,ndim = 1, lambda = o); 
X = out$projection; 
#data.matrix(X)
#X[[1]]
#getwd(); 
write.csv(X[[1]], file = "M1");
write.csv(X[[2]], file = "M2");
write.csv(X[[3]], file = "M3");
write.csv(X[[4]], file = "M4");
write.csv(X[[5]], file = "M5");
write.csv(X[[6]], file = "M6");
write.csv(X[[7]], file = "M7");
write.csv(X[[8]], file = "M8");
write.csv(X[[9]], file = "M9");
write.csv(X[[10]], file = "M10");







 
