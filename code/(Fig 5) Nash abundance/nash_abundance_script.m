close all; clc; clear

% This script computes the number of Nash equilibria in the information
% sharing game across parameter space of fidelities, (p,q) in (1/2,1)^2.
% This data is stored, and saved, in the file 'nash_abundance_kappa=5.mat'
% (similarly for kappa=1)
% % % % %
 mydir  = pwd; % get current directory
 idcs   = strfind(mydir,'\');
 parent_dir = mydir(1:idcs(end)-1);
 addpath(parent_dir)
 % % % % %
 
% coordination game
bA = 10; bB = 2; % kappa=5. Set bA=2 to get kappa=1.
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

% Get vector form of all 16 strategies
strategies = zeros(4,2^4);
for strat_num = 1 : 2^4
    strategies(:,strat_num) = dec_2_bin(strat_num-1,4)';
end

pvec = .501:.001:.999;
qvec = .501:.001:.999;

% Go through each grid point (p,q) and exhaustively check all strategy
% profiles with Nash equilibrium condition. Equilibria for each grid point
% is then counted and stored.
nash_abundance = zeros(length(pvec),length(qvec));
for y = 1 : length(pvec)
    q = qvec(y);
    y
    qb = 1-q;
    for x = 1 : length(qvec)
        p = pvec(x);
        pb = 1-p;
        Q = get_Q(p,q,cA,cB);
        [L0,L1] = get_L(p,q);
        eq_count = 0;
        % Loop through all strategy profiles. 
        for i = 1 : 16
            si = strategies(:,i);
            for j = 1 : i
                sj = strategies(:,j);
                if is_nash(si,sj,Q,eA,eB,L0,L1,A0,A1)
                    eq_count = eq_count + 1;
                end 
            end
        end
        nash_abundance(y,x) = eq_count;
    end
end
nash_abundance = nash_abundance - 2; % OA and OB are always Nash equilibria

save('nash_abundance_kappa=5.mat')

%% Test code to see list of Nash equilibria at any given (p,q)
% p = .52; q = .98;
% Q = get_Q(p,q,cA,cB);
% [L0,L1] = get_B(p,q);
% eqs = [];
% for i = 1 : 16
%     si = strategies(:,i);
%     for j = 1 : i
%         sj = strategies(:,j);
%         if is_nash(si,sj,Q,eA,eB,L0,L1,A0,A1)
%             eqs = [eqs;i,j];
%         end 
%     end
% end
% eqs