function [beta_star,X] = generateFixData(n, p, s)
% Given dimensions n and p, and sparsity number s, the
% function generates a data matrix X.
% 
% Inputs: n, p and s 
%   if s = 0 -> low dim. setting 
% Output: beta_star and X 
%

if s == 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Low Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    X = normrnd(0,1,n,p); %% Feature Matrix from Gaussian N(0,1)
    beta_star = normrnd(0,1,p,1);
    beta_star = beta_star/(norm(beta_star,2));
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % High Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
    X = normrnd(0,1,n,p);
    s_idx = randi(p,s,1); % pick s random indices from 1:p
    s_value = normrnd(0,1,s,1);
    beta_star = zeros(p,1);
    beta_star(s_idx) = s_value;
    beta_star = beta_star/(norm(beta_star,2));
end

end



