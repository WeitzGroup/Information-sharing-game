function yn = is_nash(si,sj,Q,eA,eB,L0,L1,A0,A1)

% Nash condition for pure strategy profile (si,sj), see Appendix C in SI.
% Function returns yn = 1 if (si,sj) is a Nash eq, 0 if not.
% Q: quadratic matrix in fitness formula (see SI App. A)
% eA,eB: proportion of time spent in each environment
% L0,L1: Linear vector constants in fitness calculations (see SI)
% A0,A1: Payoff matrices in each environment
% yn: 0 or 1 (not nash or is nash)

Dfi = gradient_f(sj,Q,eA,eB,L0,L1,A0,A1);
Dfj = gradient_f(si,Q,eA,eB,L0,L1,A0,A1);
yn = sum(sign(Dfi).*(2*si-1) >= 0) + sum(sign(Dfj).*(2*sj-1) >= 0) == 8;