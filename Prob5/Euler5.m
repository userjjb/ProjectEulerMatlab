function [LCM] = Euler5(N)
%Finds least common multiple on numbers 1 to N
    P = primes(N); %We should use something faster here really, Matlab's implementation is slooooow.
    A = P(P<=sqrt(N));
    LCM = prod(A.^(floor(log(N)./log(A))-1))*prod(P);
