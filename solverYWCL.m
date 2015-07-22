function [y_new, beta_hat] = solverYWCL(y,rho,c,func,s)

% loading the data matrix X, beta_star, and sparsity value
load('data.mat');

[n,p] = size(X);

T_max = 2000; % number of iterations in power method

%%%%%%%%%%%%%%%
% Second Moment Estimation
sumM = zeros(p,p);
for i = 1: n/2
    delX = X(2*i,:) - X(2*i-1,:);
    dely = y(2*i,:) - y(2*i-1,:);
    sumM = sumM + dely^2 * (delX' * delX);
end
M = 2/n * sumM;
%%%%%%%%%%%%%%%

if s == 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Low Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    beta_hat=randn(p,1);
    [beta_hat,~]=eigs(M,1);
    y_new = sign(X * beta_hat);
    %display(beta_hat');
    %beta_hat = PM(M,beta_hat,T_max);
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % High Dimensional Setting %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % n = ceil(s^2 * log(p));
    %% Initialization:    
%     cvx_begin sdp
%         variable P(p,p)
%         minimize(-trace(M'*P)+rho*norm(vec(P),1))
%         subject to
%             trace(P)==1;
%             P== semidefinite(p);
%             eye(p)-P== semidefinite(p);
%     cvx_end
    % pause
    % first leading eigenvector of pi_0
    csvwrite('M',M); 
    !Rscript FPS_solver.R
    P = csvread('M',1,1); 
    [beta_old,~] = eigs(P,1);
    %beta_old = V(:,1);
    [~,ix] = sort(abs(beta_old),'descend');
    sIndex = ix(1:s);
    beta_old_1 = zeros(p,1);
    beta_old_1(sIndex) = 1 * beta_old(sIndex);
    beta_old = beta_old_1/norm(beta_old_1,2);
    % Truncted PM
    for i = 1:T_max
        beta_new = M * beta_old;
        [~,ix] = sort(abs(beta_new(:,1)),'descend');
        sIndex = ix(1:s);
        beta_new_1 = zeros(p,1);
        beta_new_1(sIndex) = 1 * beta_new(sIndex);
        beta_old = beta_new_1/norm(beta_new_1,2);
    end
    beta_hat = beta_old;
    y_new = sign(X * beta_hat);
    
end
