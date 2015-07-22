function beta_hat = chooseBeta(beta_hat,y,X)

y1 = sign(X * beta_hat);
y2 = sign(X * beta_hat * -1); 

if (norm(y1 - y) > norm(y2 - y))
    beta_hat = -1 * beta_hat; 
end 

end 