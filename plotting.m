clc; close all; 
scsz = get(0,'ScreenSize');
pos1 = [scsz(3)/110 scsz(4)/10 scsz(3)/1.5 scsz(4)/1.5];
fig55 = figure(55);
set(fig55,'Renderer','OpenGL','Units','pixels','OuterPosition',pos1,'Color',[.95 .95 .95])
% -----------

% -----------

c1 = [.9 .2 .2]; c2 = [.2 .4 .6];  c3 = [.4 .8 .4]; c4 = [.6 .6 .6]; c5 = [.01 .9 .01]; 
c11 = [.9 .3 .3]; c22 = [.3 .5 .7];  c33 = [.5 .9 .5]; c44 = [.7 .7 .7]; c55 = [.01 .9 .01]; 
applered = [.9 .2 .2]; oceanblue = [.2 .4 .6]; neongreen = [.1 .9 .1]; 
liteblue = [.2 .9 .9]; hotpink = [.9 .1 .9]; c11 = 'none'; 
MSz = 7; 
ax = [.10 .10 .85 .85]; 

% 

nSETS = 2; 
rNcN = size(dataset1); 
DP_REP = size(dataset2); 

AveOver = 1; 
DATARATE = 1;
t = 1; 

MuDATA = dataset1; repDATA = rNcN(2); 
% ------------------------
Mu = mean(MuDATA,2)';  Sd = std(MuDATA,0,2)'; Se = Sd./sqrt(repDATA); 
y_Mu = Mu;  x_Mu = 1:(size(y_Mu,2));    e_Mu = Se; 
xx_Mu = 1:0.1:max(x_Mu); 
yy_Mu = interp1(x_Mu, y_Mu, xx_Mu, 'pchip'); 
ee_Mu = interp1(x_Mu, e_Mu, xx_Mu, 'pchip');
p_Mu = polyfit(x_Mu, Mu, 3); 
x2_Mu = 1:0.1:max(x_Mu);    y2_Mu = polyval(p_Mu, x2_Mu); 
XT_Mu = xx_Mu'; YT_Mu = yy_Mu'; ET_Mu = ee_Mu'; 
%-------------------------
hax = axes('Position', ax); 
[ph1, po1] = borderline(XT_Mu, YT_Mu, ET_Mu, 'cmap', c1, 'alpha', 'transparency', 0); 
hold on; 
% ------------------------
MuDATA = dataset2; repDATA = DP_REP(2); 
% ---------------
Mu = mean(MuDATA,2)';   Sd = std(MuDATA, 0, 2); Se = Sd ./sqrt(repDATA); 
y_Mu = Mu; 
x_Mu = 1: (size(y_Mu, 2));  e_Mu = Se; 
xx_Mu = 1:0.1:max(x_Mu); 
yy_Mu = interp1(x_Mu, y_Mu, xx_Mu, 'pchip'); 
ee_Mu = interp1(x_Mu, e_Mu, xx_Mu, 'pchip');
p_Mu = polyfit(x_Mu, Mu, 3); 
x2_Mu = 1:0.1:max(x_Mu);    y2_Mu = polyval(p_Mu, x2_Mu); 
XT_Mu = xx_Mu'; YT_Mu = yy_Mu'; ET_Mu = ee_Mu'; 
% ----------------
[ph2, po2] = borderline(XT_Mu, YT_Mu, ET_Mu, 'cmap', c44, 'alpha', 'transparency', 0); 
axis tight; hold on; 

leg1 = legend([ph1, ph2], {' Synapse-1', ' Synapse-2'}); 
set(leg1, 'Position', [.15 .85 .11 .08], 'Color', [1 1 1], 'FontSize', 14); 

% ------ 
hax2 = (get(gca)); 
xt = hax2.XTick; 
xtt = roundn(xt * AveOver * DATARATE * (t)/(60),0);
hax2.XTickLabel = xtt; 


MS1 = 5; MS2 = 2; 
set(ph1, 'LineStyle', '-', 'Color', c1, 'LineWidth', 5,...
    'Marker', 'none', 'MarkerSize', MS1, 'MarkerEdgeColor', c1); 
set(ph2, 'LineStyle', '-.', 'Color', c44, 'LineWidth', 5,...
    'Marker', 'none', 'MarkerSize', MS1, 'MarkerEdgeColor', c44); 



hTitle = title('\fontsize{20} Synapatic Recepters'); 
hXLabel = xlabel('\fontsize{16} Time (min)'); 
hYLabel = ylabel('\fontsize{16} Particles (+/- SEM)'); 
set(gca, 'FontName', 'Helvetica', 'FontSize', 12); 
set([hTitle, hXLabel, hYLabel], 'FontName', 'Century Gothic'); 
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.01 .01],...
    'XMinorTick', 'off', 'YMinorTick', 'on', 'YGrid','on', ... 
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'LineWidth', 2); 


% -------- 
haxes1 = gca; 
haxes1_pos = get(haxes1, 'Position'); 
haxes2 = axes('Position', haxes1_pos, 'Color', 'none', ...
    'XAxisLocation', 'top', 'YAxisLocation', 'right'); 
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.01 .01],...
  'XMinorTick', 'off', 'YMinorTick', 'off', 'XGrid','off', 'YGrid','off',... 
  'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], 'LineWidth', 2,...
  'XTick', [], 'YTick', []); 


