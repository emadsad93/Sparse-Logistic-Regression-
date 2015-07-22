function [diffNorm,rho,beta_hat] = runYWCL(c,func,s)

load('data.mat'); 

i = 1;
rho = 1; 
if s ~= 0
    for rho = 10.^(-3:3)
        [~, beta_hat] = solverYWCL(rho,c,func, s);
        beta_hat(i) = beta_hat;
        diffNorm(i) = norm(beta_hat - beta_star,2);
        i = i + 1;
    end
    
    [beta_hat,i] = min(diffNorm);
    rho = 10.^(i-4);
    diffNorm = norm(beta_hat - beta_star,2);
else
    
    [~, beta_hat] = solverYWCL(rho,c,func,s);
    diffNorm = norm(beta_hat - beta_star,2);

end
