clc; close all; 
scsz = get(0,'ScreenSize');
pos1 = [scsz(3)/110 scsz(4)/10 scsz(3)/1.5 scsz(4)/1.5];
fig1 = figure(1);
set(fig1,'Renderer','OpenGL','Units','pixels','OuterPosition',pos1,'Color',[.95 .95 .95])
% -----------

% -----------
x = x_ax;
y1 = PV_diffNorm;
y2  = YWCL_diffNorm; 

c1 = [.9 .2 .2]; c2 = [.2 .4 .6];  c3 = [.4 .8 .4]; c4 = [.6 .6 .6]; c5 = [.01 .9 .01]; 
c11 = [.9 .3 .3]; c22 = [.3 .5 .7];  c33 = [.5 .9 .5]; c44 = [.7 .7 .7]; c55 = [.01 .9 .01]; 
applered = [.9 .2 .2]; oceanblue = [.2 .4 .6]; neongreen = [.1 .9 .1]; 
liteblue = [.2 .9 .9]; hotpink = [.9 .1 .9]; c11 = 'none'; 
MSz = 7; 
ax = [.10 .10 .85 .85]; 

t = 1; 
AveOver = 1; 
DATARATE = 1; 
% 
hax = axes('Position', ax); 
% [ph1, po1] = borderline(x_ax, y1, [0.07 0.07], 'cmap', c1, 'alpha', 'transparency', 0); 
% hold on; 
% 
% [ph2, po2] = borderline(x_ax, y2, [0.07 0.07],'cmap', c33, 'alpha', 'transparency', 0); 
% axis tight; hold on; 
e1 = std_PV; 
e2 = std_YWCL;
y1 = mean_PV; y2 = mean_YWCL;
ph1 = errorbar(x_ax,y1,e1,'o');
hold on; 
ph2 = errorbar(x_ax,y2,e2,'o');
hold on; 

leg1 = legend([ph1, ph2], {' Plan et al', ' Yi et al'}); 
set(leg1, 'Position', [.83 .85 .11 .08], 'Color', [1 1 1], 'FontSize', 14); 

% ------ 
hax2 = (get(gca)); 
xt = hax2.XTick; 
xtt = roundn(xt * AveOver * DATARATE * (t)/(60),0);
hax2.XTickLabel = xtt; 


MS1 = 5; MS2 = 3; 
set(ph1, 'LineStyle', '-', 'Color', c1, 'LineWidth', 5,...
    'Marker', 'o', 'MarkerSize', MS1, 'MarkerEdgeColor', c1); 
set(ph2, 'LineStyle', '-.', 'Color', c33, 'LineWidth', 5,...
    'Marker', 'o', 'MarkerSize', MS1, 'MarkerEdgeColor', c33); 



hTitle = title('\fontsize{20} Comparison Plot for Logistic Function in Low Dimensional Setting '); 
hXLabel = xlabel('\fontsize{16} c (Powers of 10)'); 
hYLabel = ylabel('\fontsize{16} ||beta_h - beta_s||_2'); 
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


