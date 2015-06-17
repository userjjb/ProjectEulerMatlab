N=104750;

%Calculate logarithmic integral function to estimate prime counting
%function
%We'll use the result to properly size our prime sieve a priori

%Converging sum approach
gamma= 0.57721566490153286060651209008240243104215933593992; %Euler-Mascheroni constant
ls=@(x,k) (log(x).^k)./(k.*factorial(k)); %Make sure to verify convergence
European= gamma+log(log(2))+sum(ls(2,1:60));

li = gamma+log(log(N))+sum(ls(N,1:60)); %Estimate prime counting function for li(N)
count=li-European;

%Alternatively we could directly calculate the integral
%count=integral(@(x) 1./log(x),2,104750,'RelTol',1e-13,'AbsTol',1e-15);

%If we believe the Riemann hypothesis we can set a tighter bound on the
%error in the counting function approximation
if N>2656 %Riemann bound, Schoenfeld (1976)
    Bound=sqrt(N)*log(N)/(8*pi);
else
    dsa
end
count=count-Bound;

