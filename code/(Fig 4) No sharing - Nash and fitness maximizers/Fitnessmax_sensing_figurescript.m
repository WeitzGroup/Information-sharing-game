clear; clc; close all
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
% Figure 4 (right panel) in main text: This script plots the boundary lines that separates
% the regions in (p,log(kappa))-space of the three fitness maximizers OA, OB,
% and FC

% Define the boundary lines
pvec = .5:.001:1;
kappa_limit = 5;
branch_index = find(pvec>1/sqrt(2),1);
branch_vec = pvec(branch_index+1:end);
OA_boundary = [zeros(1,branch_index),log(branch_vec.^2./(1-branch_vec.^2))];
OB_boundary = [zeros(1,branch_index),log((1-branch_vec.^2)./branch_vec.^2)];

plot(pvec,OA_boundary,'k','linewidth',2)
hold on
plot(pvec,OB_boundary,'k','linewidth',2)
axis([.5 1 -kappa_limit kappa_limit])

pbaspect([1 1 1]) % aspect ratio square
% % % %
ax = axis;
HorizontalOffset = 0.01;

% set x and y axis limits
set(gca,'xtick',[.5,1/sqrt(2),1])
set(gca,'ytick',[-kappa_limit,0,kappa_limit])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

% place customized y axis labels (log(kappa))
text(ax(1) - HorizontalOffset,yTicks(1),['$-$',num2str(kappa_limit)],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),'$0$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(3),num2str(kappa_limit),'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Place customized x axis labels (p)
minY = min(yTicks);
verticalOffset = .65;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, '$\frac{1}{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2)+.03, minY-.4, '$1/\sqrt{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',18);
text(xTicks(3)+shift, minY-verticalOffset, '$1$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Relevant labels
text(.75, 2, 'log$(\frac{p^2}{1-p^2})$','interpreter','latex','fontsize',24)
text(.75, -2, 'log$(\frac{1-p^2}{p^2})$','interpreter','latex','fontsize',24)
text(.9, 0, 'FC','interpreter','latex','fontsize',28)
text(.6, 2, 'OA','interpreter','latex','fontsize',28)
text(.6, -2, 'OB','interpreter','latex','fontsize',28)

xlabel('sensing fidelity ($p$)','fontsize',20,'interpreter','latex')
xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [0 .05 0]);

title('Fitness maximizers','interpreter','latex','fontsize',20)
% 
saveas(gcf,'Fitnessmax_sensing.jpg')
crop('Fitnessmax_sensing.jpg')



