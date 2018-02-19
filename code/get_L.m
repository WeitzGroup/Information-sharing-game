function [L0,L1] = get_L(p,q)

% L0 and L1 are the linear vector constants in fitness calculations (see SI)
% average long-term fitness: x^TQx - c_A L0^T (s1+s2) + cA (L0 here is the same as $L_{pq}$ in the SI)
% For our purposes, we do not need L1, but for general payoff structures,
% it may be necessary.
% p,q: fidelity parameters

pb = 1-p; qb = 1-q;
l = p*q + pb*qb;
L0 = [p*l;p*(1-l);pb*l;pb*(1-l)];
L1 = flipud(L0);