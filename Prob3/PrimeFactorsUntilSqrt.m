function [Complements,PrimeFactors,PrimeFlag] = PrimeFactorsUntilSqrt(TrialNum)
%Eratosthenesian sieve up to the sqrt of TrialNum. We return all prime
%factors from the sieve that are also factors of TrialNum. We also return
%all complements of these prime factors which themselves may be prime
%factors of TrialNum as well. If no prime factors are found, then the
%TrialNum itself is actually prime and we set the PrimeFlag.

%Seed with early primes for wheel generation, 2 omitted
Seed = [3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61];
NumSeed = 1;
WheelLength = 1;
%We choose a WheelLength that gives us a "mostly" square sieve matrix to
%get the most out of vectorization
while WheelLength^2 < floor(sqrt(TrialNum))
    NumSeed = NumSeed +1;
    WheelLength = prod(Seed(1:NumSeed));
end

%We find all the wheel "spokes" that are multiples of the primes used for
%the wheel, we implicitly exclude multiples of '2'
WheelSpokes = [];
for S=1:NumSeed
    WheelSpokes = [WheelSpokes,(Seed(S)+1)/2:Seed(S):WheelLength];
end
WheelSpokes = unique(WheelSpokes);
Sieve = true(WheelLength, ceil( floor(sqrt(TrialNum))/(2*WheelLength)) );
%All spokes in the wheel are composite, except the prime Seeds
Sieve(WheelSpokes,:) = false;
Sieve((Seed+1)/2) = true;
Sieve(1) = false;

%Starting after the last Seed prime check to see if the number is prime
%(true). If it is prime then all multiples in the sieve are checked off. We
%do this for each number up until the square root of the value of the
%largest sieve number
for K=(Seed(NumSeed)+3)/2:floor(( sqrt((2*numel(Sieve))-1) +1)/2)
    if Sieve(K), Sieve(3*K-1: 2*K-1: numel(Sieve)) = false; end
end

SieveVals = (find(Sieve).*2)-1;
PrimeFactors = SieveVals(TrialNum./SieveVals == floor(TrialNum./SieveVals));
if TrialNum/2 == floor(TrialNum/2), PrimeFactors = [2 , PrimeFactors]; end
Complements = TrialNum./PrimeFactors;

if isempty(PrimeFactors), PrimeFlag = true;
else PrimeFlag = false; end
end %End PrimeFactorsUntilSqrt()
