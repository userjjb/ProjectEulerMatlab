%Project Euler problem 4
%6/16/15 Josh Bevan
clear all

N=4; %Number of digits in each factor
T=(10^(N-1):10^N-1); %Range of numbers allowed for factors, single for performance
Prd=floor(tril(T'*T)); %Non-dupliate products

Prd=Prd(mod(Prd(:),10)>0); %Remove any products with trailing zero, no palindrome possible
Digits=ceil(2*N); %Maximum number of digits in product

%Compute the value of each digit in the product
S=floor(bsxfun(@rdivide,Prd, 10.^(Digits-1:-1:0))); %Divide by powers of ten, the ones digit in the result is what we want
S=uint8(S-[zeros(length(Prd),1),10*S(:,1:end-1)]); %Subtract out everything but the ones digit for each of digit places

Res1=max(Prd(all(fliplr(S)==S,2))) %Palindromes should equal their LR flip
%Note that this computes and finds ALL palindromes in the range. A much
%faster way would estimate a minimum bound 

%Slow string manipulation way
% Res3=max(Prd(Prd==str2num(fliplr(int2str(Prd)))))