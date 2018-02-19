clear; clc; close all
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
bA = 2; bB = 2;
A0 = [bA 0; 0 0];
A1 = [0 0; 0 bB];
A0_00 = A0(1,1); A1_00 = A1(1,1);
A0_01 = A0(1,2); A1_01 = A1(1,2);
A0_10 = A0(2,1); A1_10 = A1(2,1);
A0_11 = A0(2,2); A1_11 = A1(2,2);
g0 = A0_00 - A0_01 - A0_10 + A0_11;
g1 = A1_00 - A1_01 - A1_10 + A1_11;
v_AA = .6; v_AB = .4; 
v_BA = .4; v_BB = .6;
eA = v_BA/(v_BA+v_AB); % long-term probability of being in environment 0
eB = v_AB/(v_BA+v_AB); % long-term probability of being in environment 1
cA = g0*eA; cB = g1*eB;

kappa = cA/cB;
FC = [0;0;1;1]; % follow cue strategy
F = [0;1;0;1]; % follow social cue strategy
pvec = .5:.001:1;
qvec = .5:.001:1;
FCF_nash = zeros(length(qvec),length(pvec)); % leader-follower

for y = 1 : length(qvec)
    q = qvec(y);
    for x = 1 : length(pvec)
        p = pvec(x);
        Q = get_Q(p,q,cA,cB);
        [L0,L1] = get_L(p,q);
        FCF_nash(y,x) = is_nash(FC,F,Q,eA,eB,L0,L1,A0,A1);
    end
end
%
close all
FCF_nash(FCF_nash > 0) = 50; % color scheme for FC-F region
image(pvec,qvec,FCF_nash)
axis xy

pbaspect([1 1 1])
% % % %
% set x and y axis limits
ax = axis;
set(gca,'xtick',[.5,1])
set(gca,'ytick',[.5,1])
set(gca,'yticklabel',[],'xticklabel', []) %Remove tick labels
yTicks = get(gca,'ytick');
xTicks = get(gca, 'xtick');

% place customized y axis labels (q)
HorizontalOffset = 0.01;
text(ax(1) - HorizontalOffset,yTicks(1),'$\frac{1}{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(ax(1) - HorizontalOffset,yTicks(2),'$1$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);

% Place customized x axis labels (p)
minY = min(yTicks);
verticalOffset = 0.02;
shift = 0.01;
text(xTicks(1)+shift, minY-verticalOffset, '$\frac{1}{2}$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);
text(xTicks(2)+shift, minY-verticalOffset, '$1$','HorizontalAlignment','Right','interpreter', 'latex','fontsize',20);


text(.6, .85, 'FC-F','interpreter','latex','fontsize',20)

xlabel('sensing fidelity ($p$)','fontsize',24,'interpreter','latex')
xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [0 .02 0]);

ylabel('sharing fidelity ($q$)','interpreter','latex','fontsize',24)
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [.05 0 0]);

title('$\kappa = 1$','interpreter','latex','fontsize',24)

saveas(gcf,'nash_FCF_kappa=1.jpg')
crop('nash_FCF_kappa=1.jpg')



