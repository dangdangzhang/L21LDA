function [trainsA, labelsA, trainsB, labelsB ] = split(X, labels, N)
%N为A中的个数
trainsA=[];
labelsA=[];
trainsB=[];
labelsB=[];
c= unique(labels);

for i=1:size(c,1)
     Xc = X(:,labels==i);
     [m,n]=size(Xc);

  
        selected= randperm(n);
        inx1 = selected(1:N);
        inx2=selected(N+1:n);
        trainsA=[trainsA Xc(:,inx1)];
             trainsB=[trainsB Xc(:,inx2)];
             labelsA=[labelsA;i*ones(N,1)];
             
        labelsB=[labelsB;i*ones(n-N,1)];
    
end

