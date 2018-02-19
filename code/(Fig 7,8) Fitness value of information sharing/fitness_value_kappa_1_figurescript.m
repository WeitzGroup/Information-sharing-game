close all; clc; clear
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %

% Figure 7 (left panel) in main text: This script plots a map of the
% fitness value of information sharing, V (eqn 18 in the main text), for
% kappa=1. 
kappa = 1;
pvec = .5:.001:1;
qvec = .5:.001:1;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Get fitness maximizers in the G_p game for a given kappa. The max (normalized) fitness
% values are computed for each p\in[1/2,1], and stored in welfareMax_p.
welfareMax_p = zeros(1,length(pvec));
p_strategies = zeros(2,2^2);
for strat_num = 1 : 2^2
    p_strategies(:,strat_num) = dec_2_bin(strat_num-1,2)';
end
for x = 1 : length(pvec)
    p = pvec(x);
    candidates = [];
    for i = 1 : 4
        si = p_strategies(:,i);
        for j = 1 : i
            sj = p_strategies(:,j);
            f = get_fitness_normalized_p(si,sj,p,kappa);
            candidates = [candidates;f];
        end
    end
    [maxW,~] = max(candidates);
    welfareMax_p(x) = maxW; % normalized fitness max
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% PLOT
load('fmax_kappa=1.mat') % load matrix of f_pq fitness maximizers (var: welfareMax_kappa_1)
fp_maximizers = ones(length(qvec),1)*welfareMax_p;
imagesc(pvec,qvec,welfareMax_kappa_1./fp_maximizers)
axis xy
pbaspect([1 1 1]) % aspect ratio square
ax = axis;
FC_OA = sqrt(kappa/(1+kappa));

% set x and y axis limits
set(gca,'xtick',[.5,FC_OA,1])
set(gca,'ytick',[.5,1])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

% place customized y axis labels (q)
HorizontalOffset = 0.01;
text(ax(1) - HorizontalOffset,yTicks(1),['$\frac{1}{2}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Place customized x axis labels (p)
minY = min(yTicks);
verticalOffset = 0.02;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, ['$\frac{1}{2}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
% text(xTicks(2)+shift, minY-.02, ['$\frac{1}{\sqrt{2}}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',16);
text(xTicks(3)+shift, minY-verticalOffset, ['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
%set(colorbar,'fontsize',20)

xlabel('sensing fidelity ($p$)','interpreter','latex','fontsize',20)
ylabel('sharing fidelity ($q$)','interpreter','latex','fontsize',20)
% xlab = get(gca,'xlabel');
% set(xlab,'Units','normalized');
% set(xlab,'position',get(xlab,'position') - [0 .05 0]);
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [.05 0 0]);
title({'Value of information sharing';['$\kappa=$',num2str(kappa)]},'interpreter','latex','fontsize',20)

saveas(gcf,'V_kappa=1.jpg')
crop('V_kappa=1.jpg')


