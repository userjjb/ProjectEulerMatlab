TestPrime = 11111600851475143;%600851475143

%We plan to make a sieve up to the sqrt of TestPrime. Every prime factor
%has a brother that when multiplied by gives us TestPrime. We will find at
%least one of each sibling in the sieve.
SieveMinSize = floor(sqrt(TestPrime));

%Seed with early primes for wheel generation
Seed = [3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61];
NumSeed = 1;
WheelLength = 1;
%We choose a WheelLength that gives us a "mostly" square sieve matrix to
%get the most out of vectorization
while WheelLength^2 < SieveMinSize
    WheelLength = prod(Seed(1:NumSeed));
    NumSeed = NumSeed +1;
end

%We find all the wheel "spokes" that are multiples of the primes used for
%the wheel
WheelSpokes = [];
for S=1:NumSeed
    WheelSpokes = [WheelSpokes,(Seed(S)+1)/2:Seed(S):WheelLength];
end
WheelSpokes = unique(WheelSpokes);

SieveDepth = ceil(SieveMinSize/(2*WheelLength));
%The sieve's # of rows can be 1/2 the wheel length since the prime factor
%'2' is easy to implicitly eliminate: it occurs at a regular frequency. 
Sieve = true(WheelLength,SieveDepth);
SieveLength = numel(Sieve);
%We only need to sieve up to sqrt of the largest number in the Sieve
SievePivot = floor(sqrt((2*SieveLength)-1));

Sieve(WheelSpokes,:) = false;
Sieve((Seed+1)/2) = true;
Sieve(1) = false;

%Starting after the last Seed prime check to see if the number is prime
%(true). If it is prime then all multiples in the sieve are checked off.
for K=(Seed(NumSeed)+3)/2:floor((SievePivot+1)/2)
    if Sieve(K)
        Sieve(3*K-1: 2*K-1: SieveLength) = false;
    end
end

%Returns vector of primes up to SieveMinSize, including '0' at beginning
Sieve = reshape(Sieve,SieveLength,1);
SieveVal = Sieve .* [1:2:2*SieveLength-1]';

Factors = and(TestPrime./SieveVal == floor(TestPrime./SieveVal),Sieve);

TestPrime./SieveVal(find(Factors))