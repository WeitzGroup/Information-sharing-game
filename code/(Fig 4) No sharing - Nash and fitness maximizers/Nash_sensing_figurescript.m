clear; clc; close all
% Figure 4 (left panel) in main text: This script plots the boundary lines
% that defines the FC Nash equilibrium region in (p,log(kappa))-space
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
pvec = .5:.001:1;
kappa_limit = 5;
plot(pvec,log(pvec./(1-pvec)),'k','linewidth',2)
hold on
plot(pvec,log((1-pvec)./pvec),'k','linewidth',2)
axis([.5 1 -kappa_limit kappa_limit])

pbaspect([1 1 1]) % aspect ratio square
ax = axis;

% set x and y axis limits
set(gca,'xtick',[.5,1])
set(gca,'ytick',[-kappa_limit,0,kappa_limit])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

% place customized y axis labels (log(kappa))
HorizontalOffset = 0.01;
text(ax(1) - HorizontalOffset,yTicks(1),['$-$',num2str(kappa_limit)],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),'$0$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(3),num2str(kappa_limit),'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Place customized x axis labels (p)
minY = min(yTicks);
verticalOffset = .65;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, '$\frac{1}{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2)+shift, minY-verticalOffset, '$1$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Relevant labels
text(.68, 2, 'log$(\frac{p}{1-p})$','interpreter','latex','fontsize',24)
text(.68, -2, 'log$(\frac{1-p}{p})$','interpreter','latex','fontsize',24)
text(.75, 0, 'Follow Cue','interpreter','latex','fontsize',24)

xlabel('sensing fidelity ($p$)','fontsize',20,'interpreter','latex')
xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [0 .05 0]);

ylabel('log of relative benefits (log $\kappa$)','interpreter','latex','fontsize',20)
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [.05 0 0]);

title('FC Nash Equilibrium region','interpreter','latex','fontsize',20)

saveas(gcf,'nash_sensing.jpg')
crop('nash_sensing.jpg')


