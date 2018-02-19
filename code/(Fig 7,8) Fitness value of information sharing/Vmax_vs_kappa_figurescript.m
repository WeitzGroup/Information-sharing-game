clear; clc; close all

% Figure 8 in main text: This script plots the max value of V as a function
% of kappa, see eqn 19 in text. In other words, it is a plot of the best
% possible value of information sharing as a function of the ratio of relative
% benefits, kappa.

% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %

% Functional form of Vmax depends on whether kappa < 1 and kappa >= 1. It
% attains its maximum when kappa = 1, with value sqrt(2).
dk = .001;
kappa1 = dk : dk : 1;
kappa2 = 1+dk : dk : 1/dk;
V = zeros(length(kappa1) + length(kappa2),1);

% kappa < 1
for k = 1 : length(kappa1)
    kappa = kappa1(k);
    p = 1/sqrt(kappa+1);
    V(k) = p*(2 - p*(1-kappa));
end

% kappa > 1
for k = 1 : length(kappa2)
    kappa = kappa2(k);
    p = sqrt(kappa/(1+kappa));
    V(k+length(kappa1)) = p*(2 - p*(1-(1/kappa)));
end

plot(log10(kappa1),V(1:length(kappa1)),'k','linewidth',2)
hold on
plot(log10(kappa2),V(1+length(kappa1):end),'k','linewidth',2)
axis([log10(kappa1(1)) log10(kappa2(end)) 1 1.5])
ax = axis;

% set x and y axis limits
set(gca,'xtick',[log10(kappa1(1)),0,log10(kappa2(end))])
set(gca,'ytick',[1,sqrt(2)])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

% place customized y axis labels (Vmax)
HorizontalOffset = 0.05;
text(ax(1) - HorizontalOffset,yTicks(1),'$1$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),'$\sqrt{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Place customized x axis labels (kappa)
minY = min(yTicks);
verticalOffset = 0.032;
shift = 0.2;
text(xTicks(1)+shift, minY-verticalOffset, num2str(log10(kappa1(1))),'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2), minY-.02, '$0$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(3)+shift, minY-verticalOffset, num2str(log10(kappa2(end))),'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

xlabel('Log of ratio of relative benefits ($\kappa$)','fontsize',18,'interpreter','latex')
ylabel({'max value of information sharing';'$V_{\mbox{max}}$'},'interpreter','latex','fontsize',18)

xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [0 .03 0]);
% ylab = get(gca,'ylabel');
% set(ylab,'Units','normalized');
% set(ylab,'position',get(ylab,'position') - [.08 0 0]);

saveas(gcf,'Vmax_vs_kappa.jpg')
crop('Vmax_vs_kappa.jpg')
