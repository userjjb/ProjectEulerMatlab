Sizer = 1E11;
SizerB = floor(sqrt(Sizer));

Tester = 603917*603919;

hit = 0;
val = 0;
TestMat = ones(SizerB,100)*2333;
TestMat(floor(SizerB/2),50) = 603917;

% Fastest slow method with "for" loop
dchit = 0;
dcval = 0;
for v=1:SizerB*100
    if Tester/TestMat(v) == floor(Tester/TestMat(v))
        dchit = dchit+1;
        dcval = v;
    end
end
dchit

% Vectorization candidates
resul = Tester./TestMat == floor(Tester./TestMat);
where = find(resul);

resul1B = Tester./TestMat == round(Tester./TestMat);

resul2 = not(mod(Tester,TestMat));
resul3 = mod(Tester,TestMat)==0;
resul4 = not(rem(Tester,TestMat));
resul5 = rem(Tester,TestMat)==0;
resul6 = not(mod(Tester./TestMat,floor(Tester./TestMat)));


%Non-fastest slow "for" loops

% for x=1:SizerB*100
%     if not(mod(Tester,TestMat(x)))
%         hit = hit+1;
%         val = x
%     end
% end
% hit
% 
% chit = 0;
% cval = 0;
% for y=1:SizerB*100
%     if mod(Tester,TestMat(y))==0
%         chit = chit+1;
%         cval = y
%     end
% end
% chit
% 
% bhit = 0;
% bval = 0;
% for z=1:SizerB*100
%     if not(rem(Tester,TestMat(z)))
%         bhit = bhit+1;
%         bval = z
%     end
% end
% bhit
% 
% bchit = 0;
% bcval = 0;
% for q=1:SizerB*100
%     if rem(Tester,TestMat(q))==0
%         bchit = bchit+1;
%         bcval = q
%     end
% end
% bchit

% dhit = 0;
% dval = 0;
% for u=1:SizerB*100
%     temp = Tester/TestMat(u);
%     if temp == floor(temp)
%         dhit = dhit+1;
%         dval = u
%     end
% end
% dhit

% echit = 0;
% ecval = 0;
% for c=1:SizerB*100
%     temp = TestMat(c);
%     if Tester/temp == floor(Tester/temp)
%         echit = echit+1;
%         ecval = c
%     end
% end
% echit