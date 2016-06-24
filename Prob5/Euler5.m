function [LCM] = Euler5(N)
%Finds least common multiple on numbers 1 to N, uses symbolic math toolbox
%to accomadate veeeery large numbers (~10000 digits long in 1 sec)
    P = sym(primes(N));
    A = P(P<=sqrt(N));
    LCM = prod(A.^(floor((log(N)+eps(N))./log(A))-1))*prod(P);
