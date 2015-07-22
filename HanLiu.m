function beta_hat = HanLiu(P,s,M )
[p,~] = size(P); 

[beta_old,~] = eigs(P,1);
[~,ix] = sort(abs(beta_old),'descend');
sIndex = ix(1:s);
beta_old_1 = zeros(p,1);
beta_old_1(sIndex) = 1 * beta_old(sIndex);
beta_old = beta_old_1/norm(beta_old_1,2);

%%%%%%%%%%%%%%%
% Truncted PM %
%%%%%%%%%%%%%%%
T_max = 500; % number of iterations in power method
for i = 1:T_max
    beta_new = M * beta_old;
    [~,ix] = sort(abs(beta_new(:,1)),'descend');
    sIndex = ix(1:s);
    beta_new_1 = zeros(p,1);
    beta_new_1(sIndex) = 1 * beta_new(sIndex);
    beta_old = beta_new_1/norm(beta_new_1,2);
end
beta_hat = beta_old;
%y_new = sign(X * beta_hat);


end

