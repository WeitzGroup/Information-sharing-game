function f = get_fitness_normalized_p(s1,s2,p,kappa)

% Get the normalized fitness of the non-social game, which is the raw fitness divided by cB - hence we only need p and kappa as inputs.
% Computation uses the bilinear form of the fitness equation
% constant kappa=cA/cB. The normalized fitness is simply the raw fitness divided by cB. 

% INPUTS
% s1,s2 - strategy vectors of player 1 and 2
% p: sensing fidelity (between 1/2 and 1)
% kappa: ratio of relative benefits (ranges from 0 to infty)

% This function is used for computation in fitnessMax_script.m

pb = 1-p;
Q0 = [p^2,p*pb;p*pb,pb^2];
Q1 = [pb^2,p*pb;p*pb,p^2];
B0 = [p;pb];

f = s1'*(kappa*Q0 + Q1)*s2 - kappa*B0'*(s1+s2) + kappa;

