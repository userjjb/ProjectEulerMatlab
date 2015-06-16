gamma= 0.57721566490153286060651209008240243104215933593992; %Euler-Mascheroni constant
ls=@(x,k) (log(x).^k)./(k.*factorial(k)); %Make sure to verify convergence
European= ls(2,30);

li = gamma+log(log(N))+sum(ls(N,1:60)); %Estimate prime counting function for li(N)