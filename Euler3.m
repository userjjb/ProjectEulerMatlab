TestPrime = 600851475143;%600851475143
SieveMinSize = floor(sqrt(TestPrime));
SievePivot = floor(sqrt(SieveMinSize));
Seed = [2,3,5,7,11,13,17,19];

%Use wheel factorization. This saves some computation.
NumSeed = 1;
WheelLength = Seed(NumSeed);
while WheelLength^2<SieveMinSize
    NumSeed = NumSeed+1;
    WheelLength = WheelLength*Seed(NumSeed);
end

%Generate a sieve matrix that is roughly square to optimize vectorization.
%We want to minimize column operations whiel maximizing the number of
%sieved numbers per column operation. Perhaps "square" is a suboptimal
%naive approach?
SieveDepth = ceil(SieveMinSize/WheelLength);
%The sieve's # of rows can be 1/2 the wheel length since the prime factor
%'2' is easy to implicitly eliminate: it occurs at a regular frequency. 
Sieve = true(WheelLength/2,SieveDepth);
SieveSize = (WheelLength/2)*SieveDepth;

%Compile a vector of rows that are composite (ie. multiples of the seed
%primes used in the wheel).
CompositeRowBits = false(WheelLength/2,1);
for S=2:NumSeed
    for Pos=Seed(S): 2*Seed(S): WheelLength
        CompositeRowBits((Pos+1)/2) = true;
    end
end
iter=1;
for B=1:length(CompositeRowBits)
    if CompositeRowBits(B)
        CompositeRow(iter) = B;
        iter = iter+1;
    end
end

%Remove all seed prime multiples in the sieve: guarenteed composite. Add
%back in the prime seeds.
Sieve(CompositeRow,:)=false;
for S=2:NumSeed
    Sieve((Seed(S)+1)/2,1)=true;
end

%Sieve remaining primes. Here begins the "slow" part probably.
%First column starting after seed primes
for K=((Seed(NumSeed)+2)+1)/2:WheelLength/2
    if Sieve(K,1)
      for M=3*K-1: 2*K-1: SieveSize
          Sieve(mod(M,WheelLength/2),ceil((2*M)/WheelLength))=false;
      end
    end
end
%Remainder of sieve, column by column
for j=2:SieveDepth
    for i=1:WheelLength/2
        if Sieve(i,j)
            K = (j-1)*(WheelLength/2)+i;
            for M=3*K-1: 2*K-1: SieveSize
                Sieve(mod(M,WheelLength/2),ceil((2*M)/WheelLength))=false;
            end
        end
    end
end