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
Np=137;%78 min absolute bound, 137 min L2 error
[Qx,Qw]=GLquad(Np);
Qx=round((Qx/2+0.5)*(Range-1)+1);
assert(and(all(Qx>0),all(Qx<Range+1)),'Interpolation nodes must occur within domain')

nn= elim(Qx',Qx',[1 3 2]);
Lag=@(x,nv) prod(bsxfun(@rdivide,bsxfun(@minus,x,nn(nv,:,:)),bsxfun(@minus,Qx(nv),nn(nv,:,:))),3);
px= peye(Qx);
interp=@(x) px*Lag(x,1:Np);

error=round(interp(xx))-peye(xx);
plot(xx,error)
norm(error)

Np2=10;%78 min absolute bound, 137 min L2 error
Nh=10;
[Qx2,Qw2]=GLquad(Np2);
Edges= round(linspace(1,Range,Nh+1));
for h=1:Nh
    Qx2(:,h)=round((Qx/2+0.5)*(Range-1)/Nh)+Edges(h);
    nn2(:,:,:,h)= elim(Qx2(:,h)',Qx2(:,h)',[1 3 2]);
end

Lag2=@(x,nv,h) prod(bsxfun(@rdivide,bsxfun(@minus,x,nn2(nv,:,:,h)),bsxfun(@minus,Qx2(nv,h),nn2(nv,:,:,h))),3);

px2= peye(Qx2);
interp2=@(x) px2(:,find(x>Edges,1,'last'))'*Lag2(x,1:Np2,find(x>Edges,1,'last'));

error2=round(interp2(xx))-peye(xx);
plot(xx,error2)
norm(error2)

