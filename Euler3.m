TestPrime = 600851475143;%600851475143
NumSeed = 4;

Seed = [3,5,7,11,13,17,19];
WheelLength = prod(Seed(1:NumSeed));
WheelSpokes = [];
for S=1:NumSeed
    WheelSpokes = [WheelSpokes,(Seed(S)+1)/2:Seed(S):WheelLength];
end
WheelSpokes = unique(WheelSpokes);

SieveMinSize = floor(sqrt(TestPrime));
SieveDepth = ceil(SieveMinSize/(2*WheelLength));
%The sieve's # of rows can be 1/2 the wheel length since the prime factor
%'2' is easy to implicitly eliminate: it occurs at a regular frequency. 
Sieve = true(WheelLength,SieveDepth);
SieveLength = numel(Sieve);
SievePivot = floor(sqrt((2*SieveLength)-1));

Sieve(WheelSpokes,:) = false;
Sieve(Seed) = true;

for K=(Seed(NumSeed)+3)/2:floor((SievePivot+1)/2)
    if Sieve(K)
        Sieve(3*K-1: 2*K-1: SieveLength) = false;
    end
end