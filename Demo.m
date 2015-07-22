
clear all; 
clc; 

addpath([pwd '/cvx']); 
%% Functions
clear all; 
func1 = @(z,c)((1 + exp(-c *z)).^(-1)); % E[y|x] = func
func2 = @(z,c)(cos(c * z));
func3 = @(z,c)(sin(c * z));

s = [0]; 
p = [100, 300]; 
n = [3000]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Low Dimensional Setting %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main(n(1),p(2),s(1),func1); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_100_1.fig']);

%%
main(n,p(2),s(1),func1); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_300_1.fig']);

%%
main(n,p(1),s(1),func2); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_100_2.fig']);


%%
main(n,p(2),s(1),func2); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_300_2.fig']);


%%
main(n,p(1),s(1),func3); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_100_3.fig']);


%%
main(n,p(2),s(1),func3); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/LD_300_3.fig']);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hight Dimensional Setting %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main(n,p(1),s(2),func1); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_100_1.fig']);


%%
main(n,p(2),s(2),func1); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_300_1.fig']);


%%
main(n,p(1),s(2),func2); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_100_2.fig']);


%%
main(n,p(2),s(2),func2); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_300_2.fig']);


%%
main(n,p(1),s(2),func3); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_100_3.fig']);


%%
main(n,p(2),s(2),func3); 
load('workspace.mat'); 
run plotForDemo.m
saveas(figure(1),[pwd '/plots/HD_300_3.fig']);




