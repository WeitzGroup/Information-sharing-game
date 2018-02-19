function Q = get_Q(p,q,cA,cB)

% average long-term fitness: x^TQx - 2c1B^Tx + c1

  pb = (1-p); qb = (1-q);
  Q11 = (cA*p^2 + cB*pb^2)*[q^2 q*qb;q*qb qb^2];
  Q12 = (cA+cB)*p*pb*[q*qb qb^2;q^2 q*qb];
  Q21 = (cA+cB)*p*pb*[q*qb q^2; qb^2 q*qb];
  Q22 = (cA*pb^2 + cB*p^2)*[qb^2 q*qb;q*qb q^2];
  
  
  
  Q = [Q11 Q12; Q21 Q22];