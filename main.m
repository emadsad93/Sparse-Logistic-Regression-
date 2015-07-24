function main(n, p, s, func)

k = 5; % Number of Experiments
range=[-2:0.5:2]; % range is used for generating c 
% range= inf
ind = 1:length(range); 

lambda = [1e-04,  1e-03,  1e-02, 1e-01,  1e+00,  1e+01,  1e+02,  1e+03, 1e+04, 1e+05]; 
x_ax = range;

% Initializing to all zero matrices  
PV_diffNorm = zeros(1,length(range));
YWCL_diffNorm = zeros(1,length(range));

for j = 1:k
    % Generate data X and weight vector beta_star
    [beta_star,X] = generateFixData(n,p,s);
    
    ind = 1;
    for c = [10.^range]
        for t = 1:k
            % generate y 
            fprintf('c is %d, experiment %d x %d t\n', c, j,t); 
            y = sign((func(X * beta_star,c)) - rand(n,1));
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
                %fprintf('Done with CVX\n')
                % y_new = sign(X * beta_hat);
                
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
                
                % y_new = sign(X * beta_hat);
            end
            % y_PV = y_new;
            beta_hat_PV = beta_hat;
            
            PV_diffNorm(ind, (j-1) * k + t) = norm(beta_hat_PV - beta_star);
            %fprintf('%d', beta_hat_PV);             
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
                [beta_hat,~]=eigs(M,1);
                %y_new = sign(X * beta_hat);
            else
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % High Dimensional Setting %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                csvwrite('M',M);
                
                %%%%%%%%%%%%%%%
                % Calling FPS %
                %%%%%%%%%%%%%%%
                fprintf('About to call R script...\n'); 

                !Rscript FPS_solver.R  
                
                normLambda = zeros(1,10);
                beta_hat_10 = zeros(p,10); 
                for v = 1:10
                    name = strcat('M', num2str(v)); 
                    P = csvread(name,1,1);
                    beta_hat_10(:,v) = HanLiu(P,s,M); 
                    normLambda(v) =  norm(beta_hat_10(:,v) - beta_star); 
                end 
                [~, indexLambda] = min(normLambda); 
                beta_hat = beta_hat_10(:,indexLambda); 
            end
            % y_YWCL = y_new;
            beta_hat_YWCL = beta_hat; 
            beta_hat_YWCL = chooseBeta(beta_hat_YWCL, y,X);
            
            YWCL_diffNorm(ind,(j-1) * k + t) = norm(beta_hat_YWCL - beta_star);
            
        end
        ind = ind + 1;
    end
end
fprintf('About to compute mean and sd for plotting\n'); 

for i = 1:length(range)
    std_PV(1,i) = std(PV_diffNorm(i,:));
    mean_PV(1,i) = mean(PV_diffNorm(i,:));
    std_YWCL(1,i) = std(YWCL_diffNorm(i,:));
    mean_YWCL(1,i) = mean(YWCL_diffNorm(i,:));
end

save('workspace');
end



