close all
p = .5:.001:1;
q = .5:.001:1;
pb = 1-p;
qb = 1-q;
kappa = .2;


MLE_A0 = (1/(1+kappa))^.5;
p = linspace(.5,MLE_A0,100);
pb = 1-p;
ML_A1 = (-2*pb.*(2*p-1) + sqrt((2*pb.*(2*p-1)).^2+8*p.*pb.*(kappa*p.^2+pb.^2)))./( 2*(kappa*p.^2+pb.^2));
plot(p,ML_A1,'k','linewidth',2) % ML/A0 line divide
hold on
p = linspace(MLE_A0,1,100);
pb = 1-p;
ML_MLE = (-2*pb.*(2*p-1) + sqrt((2*pb.*(2*p-1)).^2 - 4*((1-2*p.*pb) - (kappa+1)*p.^2).*(kappa*p.^2+pb.^2)))./( 2*(kappa*p.^2+pb.^2));

plot(p,ML_MLE,'k','linewidth',2) % ML/MLE line divide
plot([MLE_A0,MLE_A0],[.5,ML_MLE(1)],'k','linewidth',2)
axis([.5 1 .5 1])

pbaspect([1 1 1])
% % % % % % %
ax = axis;
HorizontalOffset = 0.01;
set(gca,'xtick',[.5,MLE_A0,1])
set(gca,'ytick',[.5,1])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

text(ax(1) - HorizontalOffset,yTicks(1),['$\frac{1}{2}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

minY = min(yTicks);
verticalOffset = 0.02;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, ['$\frac{1}{2}$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2)-shift, minY-.03, ['$\left(\sqrt{\frac{\kappa}{\kappa + 1}}, \frac{1}{\sqrt{\kappa+1}}\right)$'],'HorizontalAlignment','Center','interpreter', 'latex','fontsize',20);
text(xTicks(3)+shift, minY-verticalOffset, ['$1$'],'HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

text(.65, .7, '(A0,A1)','interpreter','latex','fontsize',24)
text(MLE_A0-.05,.9,'(ML,$\overline{\mbox{ML}})$','HorizontalAlignment','Center','interpreter','latex','fontsize',24)
text(.92, .55, 'MLE','interpreter','latex','fontsize',24)

xlabel('$p$','fontsize',24,'interpreter','latex')
ylabel('$q$','rotation',0,'interpreter','latex','fontsize',24)
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [.05 0 0]);
title('$\kappa = (5,\frac{1}{5})$','interpreter','latex','fontsize',24)
scatter((2*(1+kappa)-sqrt(4+12*kappa))/2*(kappa-1),1)
% saveas(gcf,'fmax_kappa=fifth.png')
% crop('fmax_kappa=fifth.png')
