function [FactorizableFlag] = Factorize(TrialNum,FactorList)
%Attempt to factorize a TrialNum completely using numbers in FactorList
Factorized =  TrialNum;
for i=length(FactorList):-1:1
    while Factorized/FactorList(i) == floor(Factorized/FactorList(i))
        Factorized = Factorized/FactorList(i);
    end
    %Break early if we find the full factorization
    if Factorized == 1, FactorizableFlag=true; return; end
end
FactorizableFlag = false;
end %End Factorize()