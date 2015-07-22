function [y_new, beta_hat] = solverPV(y,c,func,s)
% For invoking the high-dim solver, use an s value that is smaller than
% both n and p values. Otherwise, set s equal to zero.

% Assumptions:
% 1) LD Setting
%    p << n
%    beta_star is generated randomly from N(0,1), and then is normalized by
%    dividing the result by its 2-norm.

% 2) HD Setting
%    beta_star is s-sparse.
%    s << p and n; n ~ log(2 * p/s) * s;
%    beta_star is created, by first, generating s indices(randomly from
%    N(0,1)) with their corresponding s values (randomly from N(0,1)), and then,
%    Normalizing the result by dividing the resulting data by its 2-norm.

load('data.mat');

[n,p] = size(X);

if s == 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Low Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    cvx_begin quiet
        variable beta_hat(p)
        minimize(- (y' * (X * beta_hat)));
        subject to
            norm(beta_hat,2) <= 1;
    cvx_end
    
    y_new = sign(X * beta_hat);
    
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % High Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cvx_begin quiet
        variable beta_hat(p)
        minimize(- (y' * (X * beta_hat)));
        subject to
            norm(beta_hat,2) <= 1;
            norm(beta_hat,1) <= sqrt(s);
    cvx_end
    
    y_new = sign(X * beta_hat);
end

end

