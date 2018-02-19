clear; clc; close all
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir) % add parent directory to path
% % % % %
round_err = -9; % round-off error
bA = 5; bB = 1; % coordination payoffs
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
strategies = zeros(4,2^4);
for strat_num = 1 : 2^4
    strategies(:,strat_num) = dec_2_bin(strat_num-1,4)';
end

pvec = .5:.001:1;
qvec = .5:.001:1;
welfareMax_ID = zeros(length(pvec),length(qvec));
welfareMax = zeros(length(pvec),length(qvec));

for y = 1 : length(qvec)
    y
    q = qvec(y);
    qb = 1-q;
    for x = 1 : length(pvec)
        p = pvec(x);
        pb = 1-p;
        
        % loop through all strategy profiles to find the fitness maximizer
        % (among all strategy profiles)
        candidates = [];
        for i = 1 : 16
            si = strategies(:,i);
            for j = 1 : i
                sj = strategies(:,j);
                f = get_fitness_normalized_pq(si,sj,p,q,kappa);
                
                % rounding relieves some inherent numerical decrepancies by
                % MATLAB. In some regions, e.g. when OA/OB maximize fitness
                % in the same region, MATLAB might determine OA is the
                % maximizer for some grid points, and OB for others,
                % producing a spotty looking result when plotting the
                % image. 
                fr = round(f*10^(-round_err))/(10^(-round_err));
                candidates = [candidates;i,j,fr];
            end
        end
        [maxW,ind_max] = max(candidates(:,end));
        welfareMax_ID(y,x) = ind_max; % which strategies maximize
        welfareMax(y,x) = maxW; % normalized fitness max     
    end
end
save('fmax_kappa=5.mat')
