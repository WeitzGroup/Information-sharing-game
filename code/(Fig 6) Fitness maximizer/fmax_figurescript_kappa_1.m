close all; clear; clc
% This script displays the fitness maximizer regions across the (p,q) fidelity
% parameters for kappa=1 (Figure 7 left). The fitness max regions are
% loaded in through 'fmax_kappa=1.mat', which was computed in the script
% "fitnessMax_script_pq.m" with kappa set to 1. This data gives identities
% of the fitness-maximizing strategies at each grid point. This script
% enhances the image by drawing the boundary lines, as computed in Appendix
% F of the SI.
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
load('fmax_kappa=1.mat') % loads welfareMax_ID
p = .5:.001:1;
q = .5:.001:1;
pb = 1-p;
qb = 1-q;
kappa = 1;

imagesc(pvec,qvec,welfareMax_ID)
axis xy
hold on

% Point in p axis that separates OA/OB and FC as fitness maximizers
FC_OA = (kappa/(1+kappa))^.5;
p = linspace(.5,FC_OA,100);
pb = 1-p;

% The boundary lines ML_OA and ML_FC are computed in SI, appendix F
ML_OA = (-2*kappa*pb.*(2*p-1) + sqrt((2*kappa*pb.*(2*p-1)).^2+8*kappa*p.*pb.*(kappa*pb.^2+p.^2)))./( 2*(kappa*pb.^2+p.^2));
plot(p,ML_OA,'k','linewidth',2) % ML/OA line divide
hold on

p = linspace(FC_OA,1,100);
pb = 1-p;
ML_FC = (-2*kappa*pb.*(2*p-1) + sqrt((2*kappa*pb.*(2*p-1)).^2 - 4*(kappa*(1-2*p.*pb) - (kappa+1)*p.^2).*(kappa*pb.^2+p.^2)))./( 2*(kappa*pb.^2+p.^2));

plot(p,ML_FC,'k','linewidth',2) % ML/FC line divide
plot([FC_OA,FC_OA],[.5,ML_FC(1)],'k','linewidth',2)
axis([.5 1 .5 1])
pbaspect([1 1 1]) % aspect ratio square
% % % % % % %

% set x and y axis limits
ax = axis;
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
verticalOffset = 0.03;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, ['$\frac{1}{2}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2)+.04, minY+.02, ['$\frac{1}{\sqrt{2}}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(3)+shift, minY-verticalOffset, ['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Region labels
text(.52, .6, 'OA/OB','interpreter','latex','fontsize',24)
text(FC_OA,.9,'$\mbox{ML}_A$/$\mbox{ML}_B$','HorizontalAlignment','Center','interpreter','latex','fontsize',24)
text(.85, .6, 'FC','interpreter','latex','fontsize',24)

xlabel('sensing fidelity ($p$)','fontsize',20,'interpreter','latex')
xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [0 .02 0]);

ylabel('sharing fidelity ($q$)','interpreter','latex','fontsize',20)
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [.05 0 0]);
title('$\kappa = 1$','interpreter','latex','fontsize',24)

saveas(gcf,'fmax_kappa=1.jpg')
crop('fmax_kappa=1.jpg')

% % For SI figure - labels for boundary parameterizations in Appendix F
% text(.62, .8, '(e)','interpreter','latex','fontsize',20)
% text(.85, .8, '(f)','interpreter','latex','fontsize',24)
% saveas(gcf,'fmax_kappa=1_qc.jpg')
% crop('fmax_kappa=1_qc.jpg')

