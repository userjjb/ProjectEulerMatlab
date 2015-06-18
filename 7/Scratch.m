Range=10^6; %Range to examine

%Directly calculate pi(x) up to Range, this is memory heavy
p=primes(Range);
intervals=ceil((numel(p)*Range)/10^9);
assert(intervals<Range,'Number of primes too large')
split=round(linspace(1,Range,intervals+1));
for i=1:intervals
    peye(split(i):split(i+1))=sum(bsxfun(@lt,p',(split(i):split(i+1))+1));
end

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

error=round(interp(xx))-peye(xx);
plot(xx,error)
norm(error)
