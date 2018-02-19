function f_normalized = get_fitness_normalized_pq(s1,s2,p,q,kappa)

% For computation in fitnessMax_script.m

% Get the normalized fitness of the non-social game, which is the raw fitness divided by cB
% Hence we only need p and kappa as inputs.
% Computation uses the bilinear form of the fitness equation
% constant kappa=c0/c1. The normalized fitness is simply the raw fitness divided by cB. 

% INPUTS
% s1,s2 - strategy vectors of player 1 and 2
% p: sensing fidelity (between 1/2 and 1)
% kappa: ratio of relative benefits (ranges from 0 to infty)

% This function is used for computation in fitnessMax_script.m

pb = (1-p); qb = (1-q);

QA = [p^2*q^2, p^2*q*qb, p*pb*q*qb, p*pb*qb^2;...
      p^2*q*qb, p^2*qb^2, p*pb*q^2, p*pb*q*qb;...
      p*pb*q*qb, p*pb*q^2, pb^2*qb^2, pb^2*q*qb;...
      p*pb*qb^2, p*pb*q*qb, pb^2*q*qb, pb^2*q^2];
  
QB = [pb^2*q^2, pb^2*q*qb, p*pb*q*qb, p*pb*qb^2;...
      pb^2*q*qb, pb^2*qb^2, p*pb*q^2, p*pb*q*qb;...
      p*pb*q*qb, p*pb*q^2, p^2*qb^2, p^2*q*qb;...
      p*pb*qb^2, p*pb*q*qb, p^2*q*qb, p^2*q^2];
[L0,~] = get_L(p,q);
f_normalized = s1'*(kappa*QA + QB)*s2 - kappa*L0'*(s1+s2) + kappa;

