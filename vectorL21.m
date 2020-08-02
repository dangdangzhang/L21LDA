function b = vectorL21(trainsample,testsample,trainlabel,testlabel,U)
b = [];
[n1,m1] = size(testsample);
[n10,m10] = size(trainsample);
%A=zeros(n1*m1,s1);
%B=zeros(n1*m1,s2);

    
%W = LpMultiplefetures(trainsample, FN,iter,pp);
t=U'*testsample;
         t2=U'*trainsample;
         Mdl = fitcknn(t2',trainlabel','NumNeighbors',1,'Distance','cityblock' );
      test1sample = predict(Mdl,t');
         
          % test1sample= knnclassify(t',t2',trainlabel');     
          b=(sum(testlabel==test1sample)/m1);     

    
     