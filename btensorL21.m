function b = btensorL21(trainsample,testsample,trainlabel,testlabel,U,V)
b = [];
[n1,m1,s1] = size(testsample);
[n10,m10,s2] = size(trainsample);
%A=zeros(n1*m1,s1);
%B=zeros(n1*m1,s2);
W = [];
%[trainsample1,trainlabel1]=sw(trainsample,trainlabel,100) ;
for i=1:s1
      temp=U'*testsample(:,:,i)*V;
       A(:,i)=temp(:);
end
for i=1:s2
    temp=U'*trainsample(:,:,i)*V;
    B(:,i)=temp(:);
end
    
%W = LpMultiplefetures(trainsample, FN,iter,pp);
%Mdl = fitcknn(B',trainlabel','NumNeighbors',1);
      Mdl = fitcknn(B',trainlabel','NumNeighbors',1,'Distance','cityblock');
      test1sample = predict(Mdl,A');
      %test1sample= knnclassify(A',B',trainlabel');     
    b=(sum(testlabel==test1sample)/s1);     
