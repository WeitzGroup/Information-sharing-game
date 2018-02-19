close all; clear; clc
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
load('nash_abundance_kappa=5.mat') % Matrix computed from "nash_abundance_script"

pvec = .5:.001:1;
qvec = .5:.001:1;
imagesc(pvec,qvec,nash_abundance)
axis xy
axis([.5 1 .5 1])
pbaspect([1 1 1]) % aspect ratio square

% set x and y axis limits
ax = axis;
set(gca,'xtick',[.5,1])
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
text(xTicks(2)+shift, minY-verticalOffset, ['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

xlabel('sensing fidelity ($p$)','fontsize',24,'interpreter','latex')
% ylabel('sharing fidelity ($q$)','interpreter','latex','fontsize',24)
% ylab = get(gca,'ylabel');
% set(ylab,'Units','normalized');
% set(ylab,'position',get(ylab,'position') - [.05 0 0]);
title('$\kappa = 5$','interpreter','latex','fontsize',24)
h = colorbar;
ylabel(h, {'number of Nash equilibria';'not including OA,OB'},'interpreter','latex','fontsize',16)
set(h,'fontsize',16)
saveas(gcf,'nash_abundance_kappa=5.jpg')
crop('nash_abundance_kappa=5.jpg')


