Range=10^5; %Range to examine

%Directly calculate pi(x) up to Range, this is memory heavy
p=primes(Range);
peye=sum(bsxfun(@lt,p',(1:Range)+1));
xx=round(linspace(1,Range,10000));

%Generate a Np point interpolation of pi(x)
Np=19;
[Qx,Qw]=GLquad(Np);
Qx=round((Qx+1)*(Range/2));
assert(and(all(Qx>0),all(Qx<Range+1)),'Interpolation nodes must occur within domain')

nn= elim(Qx',Qx',[1 3 2]);
Lag=@(x,nv) prod(bsxfun(@rdivide,bsxfun(@minus,x,nn(nv,:,:)),bsxfun(@minus,Qx(nv),nn(nv,:,:))),3);
px= peye(Qx);
interp=@(x) px*Lag(x,1:Np);
L2(i)=norm(round(interp(xx))-peye(xx));

error=round(interp(xx))-peye(xx);
plot(xx,error,'r')
norm(error)
