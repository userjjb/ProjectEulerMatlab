TrialNum=603;
%function [GreatPrimeFactor] = GreatestPrimeFactor(TrialNum)
%Returns greatest prime factor of TrialNum
%Use 600851475143 for Euler Prob 3
[Complements,PrimeFactors,PrimeFlag] = PrimeFactorsUntilSqrt(TrialNum);
if PrimeFlag, GreatPrimeFactor=TrialNum; return, end

%Test to see if all prime factors are less than sqrt(TrialNum)
Factorized = Factorize(TrialNum,PrimeFactors);

if Factorized, GreatPrimeFactor = PrimeFactors(end);
%If we can not get a complete factorization from the main prime factors,
%then there exists at least one complement who is also prime
else
    for i=length(Complements):-1:1
        [~,~,PrimeFlag] = PrimeFactorsUntilSqrt(Complements(i));
        if PrimeFlag, GreatPrimeFactor=Complements(i); return, end
    end
    error('GPF:UnhandledNum','Unhandled number: Primary prime factors do not provide full factorization, but no prime complements found');
end
%end %End GreatestNumFactor()