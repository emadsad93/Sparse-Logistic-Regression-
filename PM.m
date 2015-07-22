function [beta_hat]=PM(M,beta_star,T_max)
% calculates the largest eigenvalue and corresponding eigenvector of
% matrix A by the power method using x0 as the starting vector and % carrying out nit interactions.
%
oldBeta = beta_star; 
newBeta = oldBeta; 
for t = 1:T_max
    newBeta = M*oldBeta;
    newBeta = newBeta/norm(newBeta);
end

beta_hat = newBeta; 

end