function [w_best,ERRt,opt_lambda,ypav_best] = ...
    SIM_gd_oneshot_ls(DATA,metric,lip_flag)

% DATA    = structure with the following fields
% X       = training data
% y       = training responses
% Xh      = hold out data
% yh      = hold out responses
% Xtest      = test data
% ytest      = test responses
% thfun   = atom selection function
% lambda    = regularization parameter range
% steps    = step legth parameter range

% maxiter = total iterations of the algorithm
% metric  = error metric
% k       = number of gradient descent teps to take >=1
% tol     = gd convergence tolerance
  
% what  = output
% vhat  = knots for the best function
% yhat  = y for the best function
% ERRh  = hold out error corresponding to what
% ERRt  = Test error
% lip_flag = flag which tells whether we want 
%    Lipschitz fits or not

X = DATA.X;
y = DATA.y;
Xh=DATA.Xh;
yh=DATA.yh;
Xt = DATA.Xt;
yt = DATA.yt;
lambdas = DATA.lambda;
thfun = DATA.thfun;
if(isfield(DATA,'groups'))
    grouplasso=true;
    groups=DATA.groups;
else
    grouplasso=false;
end
clear DATA;


[n,p] = size(X);


temp=thfun([0.5,0.5],1);
if(grouplasso)
    method='L1group';
else
    if(norm(temp)==0)
        % then we are doing elastic net
        method='elastic-net';
      
    else
        % we are doing just least squares
        method='lsq';
    end
end

%mu/2 is the coefficient of squared norm regularization
% used in elastic net


mu = 0.1; 
best_err=inf;

%lambdas=[lambdas,0.0005,0.0001,0.001,0.005,10,0.5,1,1.5,3,4,5,6,7];
%lambdas=[lambdas,0.1:0.1:1,0.005,0.007,0.015,0.050,0.075,0.090,...
 %   0.0005,0.0001,0.0007,0.00005,0.00001,0.00007,0.000001];
lambdas=sort(lambdas);

for l = lambdas
    if(strcmpi(method,'elastic-net'))
        lambdaL2 = mu*ones(p,1);
        lambdaL1 = l*ones(p,1);
        funObj = @(w)SquaredError(w,X,y);
        penalizedFunObj = @(w)penalizedL2(w,funObj,lambdaL2);
        %fprintf('\nComputing Elastic Net Coefficients...\n');
        options=[];
        options.verbose=0;
        w = L1General2_PSSgb(penalizedFunObj,zeros(p,1),lambdaL1,options);
        
    else
        if(strcmpi(method,'lsq'))
            % just least squares
            Xty = (X'*y)/n;
            cov=(X'*X)/n;
            w=(cov+0.5*l*eye(p))\Xty;
        else
            % perform L1 regularized least squares
            options.norm = 2;
            options.verbose=0;
            funObj = @(w)SquaredError(w,X,y);
            
            w=L1GeneralGroup_Auxiliary(funObj,zeros(p,1),l,groups,options);
        end
    end

    if(~lip_flag)
        ypav = pav_new(X*w,y);
    else
        % We want Lipschitz fits
        ypav=lipschitz_pav(X*w,y);
    end
    yhold = pav_interpolate(Xh*w, X*w, ypav);
    [err]=CalculateError(yhold,yh,metric);
    if(err<best_err)
        best_err=err;
        w_best=w;
        ypav_best=ypav;
        opt_lambda=l;
        
    end
end
% compute test error
yout = pav_interpolate(Xt*w_best, X*w_best, ypav_best);
ERRt  = CalculateError(yt,yout,metric);
end

function[err_new]=CalculateError(y1,y2,metric)
if strcmpi(metric,'ber')
    err_new = ber(y1,y2);
elseif strcmpi(metric,'hamming')
    err_new = sum(y1~=sign(y2))/numel(y2);
else
    err_new = norm(y1-y2)^2/numel(y2);
end
%fprintf('err_new calculated to %f\n',err_new);

end