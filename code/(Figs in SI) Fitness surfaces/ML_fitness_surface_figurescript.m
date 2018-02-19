clear; clc; close all
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
bA = 1; bB = 1; % coordination payoffs
v_AA = .6; v_AB = .4; % environment switching probabilities
v_BA = .4; v_BB = .6;

A0 = [bA 0; 0 0];
A1 = [0 0; 0 bB];
A0_00 = A0(1,1); A1_00 = A1(1,1);
A0_01 = A0(1,2); A1_01 = A1(1,2);
A0_10 = A0(2,1); A1_10 = A1(2,1);
A0_11 = A0(2,2); A1_11 = A1(2,2);
g0 = A0_00 - A0_01 - A0_10 + A0_11;
g1 = A1_00 - A1_01 - A1_10 + A1_11;

eA = v_BA/(v_BA+v_AB);
eB = v_AB/(v_BA+v_AB);

cA = bA*v_BA/(v_BA+v_AB);
cB = bB*v_AB/(v_BA+v_AB);
kappa = cA/cB;

s_FC = [0 0 1 1]';
s_ML = [0 1 1 1]';

pvec = .5:.01:1;
qvec = .5:.01:1;
f_FC = zeros(length(qvec),length(pvec));
f_ML = zeros(length(qvec),length(pvec));
f_test = zeros(length(qvec),length(pvec));
for y = 1 : length(qvec)
    
    q = qvec(y);
    for x = 1 : length(pvec)
        p = pvec(x);
        Q = get_Q(p,q,cA,cB);
        [L0,L1] = get_L(p,q);
        f_ML(y,x) = s_ML'*Q*s_ML - cA*L0'*(s_ML+s_ML) + cA; % General fitness formula f_{pq} (see SI)
        f_FC(y,x) = s_FC'*Q*s_FC - cA*L0'*(s_FC+s_FC) + cA;
    end
end

surf(pvec,qvec,f_ML)
axis([.5 1 .5 1 .2 1])
pbaspect([1 1 1])
ax = axis;

set(gca,'xtick',[.5,1])
set(gca,'ytick',[.5,1])
set(gca,'ztick',[0,.5,1])

xlabel('$p$','fontsize',24,'interpreter','latex')
xlab = get(gca,'xlabel');
set(xlab,'Units','normalized');
set(xlab,'position',get(xlab,'position') - [-.1 -.1 0]);
set(gca, 'FontSize', 20)

ylabel('$q$','rotation',0,'interpreter','latex','fontsize',24)
ylab = get(gca,'ylabel');
set(ylab,'Units','normalized');
set(ylab,'position',get(ylab,'position') - [-.05 -.15 0]);
set(gca, 'FontSize', 20)

zlabel('$f_{pq}$','rotation',0,'interpreter','latex','fontsize',24)
zlab = get(gca,'zlabel');
set(zlab,'Units','normalized');
set(zlab,'position',get(zlab,'position') - [.1 0 0]);
set(gca, 'FontSize', 20)

title('ML fitness','fontsize',24,'interpreter','latex')
colormap('gray')

saveas(gcf,'f_ML_kappa=1.jpg')
crop('f_ML_kappa=1.jpg')


        
        

       