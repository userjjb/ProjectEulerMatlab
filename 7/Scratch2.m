Np2=10;%78 min absolute bound, 137 min L2 error
Nh=10;
[QxTemp,Qw2]=GLquad(Np2);
Edges= round(linspace(1,Range,Nh+1));
for h=1:Nh
    Qx2(:,h)=round((QxTemp/2+0.5)*(Range-1)/Nh)+Edges(h);
    nn2(:,:,:,h)= elim(Qx2(:,h)',Qx2(:,h)',[1 3 2]);
end

Lag2=@(x,nv,h) prod(bsxfun(@rdivide,bsxfun(@minus,x,nn2(nv,:,:,h)),bsxfun(@minus,Qx2(nv,h),nn2(nv,:,:,h))),3);

px2= peye(Qx2);
interp2=@(x) px2(:,find(x>Edges,1,'last'))'*Lag2(x,1:Np2,find(x>Edges,1,'last'));

error2=round(interp2(xx))-peye(xx);
plot(xx,error2)
norm(error2)