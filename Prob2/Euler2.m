%Project Euler #2
%Sum of even Fibonacci's with F1=1 and F2=2 and F3 =F1+F2 etc

%Generating Fib numbers 1 and 2
A=1;
B=2;
iter=1;
while B<4000000
    if not(mod(B,2))
        Exact(iter)=B;
        iter=iter+1;
    end
    temp=B;
    B=A+B;
    A=temp;
end

%Golden ratio cubed i.e. three iterations of the Fibonacci sequence
Phi3 = 2+sqrt(5);
%Starting even Fib
B=2;
iter=1;
while B<4000000
    Rough(iter)=B;
    iter=iter+1;
    %We must round after each new even Fib otherwise the results will
    %diverge
    B=round(B*Phi3);
end

%Exact and Rough should be identical lists of even Fibs. Rough should be
%faster

sum(Rough)