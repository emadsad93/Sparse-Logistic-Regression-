%%  Plots/Demos: Low Dimensional Setting
%% Clear all 
clc;
clear;

func2 = @(z,c)((1 + exp(-c *z)).^(-1)); % E[y|x] = func
func3 = @(z,c)(cos(c * z));
func1 = @(z,c)(sin(c * z));

%% Low Dimensional Setting 
rho = 0; p = 100; s = 0; n = 3000;

k = 20; % Number of Experiments

range=[-4:0.5:4];
% range= inf

ind = 1:length(range); 

x_ax = range;
PV_diffNorm = zeros(1,length(range));
YWCL_diffNorm = zeros(1,length(range));

for j = 1:k
    % Generate and fix data matrix X and beta_star
    generateFixData(n,p,s);
    
    % load X, beta_star and s
    load('data.mat');
    ind = 1; 
    for c = [10.^range]
       for t = 1:k
           % generate y from func, X, beta_star, and c
           y_old = func2(X * beta_star,c);
           % r = rand(n,1); %% CHANGE THIS
           % neg_ind = find(y_beforeCoin < r);
           % y_afterCoin = y_beforeCoin;
           % y_afterCoin(neg_ind) = -1;
           % pos_ind = find(y_beforeCoin > r);
           % y_afterCoin(pos_ind) = 1;
           % y = y_afterCoin;
            
            y = sign(y_old - rand(n,1));
            
            [y_PV, beta_hat_PV] = solverPV(y,c,func2,s);
            %PV_diffNorm(i,j) = norm(beta_hat_PV - beta_star);
            % beta_hat_PV = chooseBeta(beta_hat_PV, y,X);
            PV_diffNorm(ind, (j-1) * k + t) = norm(beta_hat_PV - beta_star);

            [y_YWCL, beta_hat_YWCL] = solverYWCL(y,c,func2,s);
            beta_hat_YWCL = chooseBeta(beta_hat_YWCL, y,X);

            %YWCL_diffNorm(i,j) = norm(beta_hat_YWCL - beta_star);
            YWCL_diffNorm(ind,(j-1) * k + t) = norm(beta_hat_YWCL - beta_star);

       end
       
%        PV_1 = mean(PV_diffNorm(1,:)); 
%        YWCL_1 = mean(YWCL_diffNorm(1,:));   
%        PV_diffNorm(i,j) = PV_1; 
%        YWCL_diffNorm(i,j) = YWCL_1;

        ind = ind + 1; 
    end
end
for i = 1:length(range)
    std_PV(1,i) = std(PV_diffNorm(i,:));
    mean_PV(1,i) = mean(PV_diffNorm(i,:));
    std_YWCL(1,i) = std(YWCL_diffNorm(i,:));
    mean_YWCL(1,i) = mean(YWCL_diffNorm(i,:));
end

save('workspace'); 



