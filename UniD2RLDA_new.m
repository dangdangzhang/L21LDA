function [W1,ob,Mean2] = UniD2RLDA_new(X, y, m, MaxIter,Pa1, Pa2)
% X: data, is a sample 
% y: label vector
% m: reduced dimensions
% MaxIter is the number of iterations
% Pa1 Pa2 are two paramters in the model



c = length(unique(y));
[d1,d2,n] = size(X);
  mean1=mean(X,3);
  for i=1:n
      X(:,:,i)=X(:,:,i)-mean1;
  end
  AA1=zeros(d1,d1);
  AA2=zeros(d2,d2);
for i=1:n
    AA1=AA1+ X(:,:,i)* X(:,:,i)';
    AA2=AA2+ X(:,:,i)'* X(:,:,i);
end

for i=1:c
    Xc{i} = X(:,:,y==i);
    nc(i) = size(Xc{i},3);
    dc{i} = ones(nc(i),1);
    q1{i}= ones(nc(i),1)/size(Xc{i},3);
end
[W10,S1,V1]=svd(AA1/n);
[W20,S2,V2]=svd(AA2/n);
W1=W10(:,1:m);
W2=W20(:,1:m);%
W1 = orth(rand(d1,m));
W2 = eye(d1,d1);
q2=ones(n,1)/n;

Mean2 =cell(c,1);
temp=cell(c,1);

 temp3=0;
    for i=1:c
        Xi = Xc{i};
        ni = nc(i);
        temp2=0;
          sum1=zeros(d1,d2);
        for j=1:ni
            sum1=sum1+dc{i}(j)*q1{i}(j)*Xi(:,:,j);
           
        end
         
            
        Mean2{i}=sum1/sum(dc{i}.*q1{i});
        for j=1:ni
            temp2=temp2+(norm(Xi(:,:,j)-Mean2{i},'fro'));
            temp3=temp3+(norm(Xi(:,:,j),'fro'));
        end
        temp{i}=temp2/ni;
       
            
            
      
      
      
    end
    temp3=temp3/n;
      Pa2=Pa2*temp3;
 Mean2 =cell(c,1);
for iter  = 1:MaxIter
% calculate A and mk
  
    
  
   sum2=0;
    for i=1:c
        Xi = Xc{i};
        ni = nc(i);
          sum1=zeros(d1,d2);
        for j=1:ni
            sum1=sum1+dc{i}(j)*q1{i}(j)*Xi(:,:,j);
           
        end
         
            
      Mean2{i}=sum1/sum(dc{i}.*q1{i});
        for j=1:ni
         sum2=sum2+q1{i}(j)*norm(W1'*(Xi(:,:,j)-Mean2{i}),'fro')+(Pa1*temp{i})*q1{i}(j)*(log(ni*(q1{i}(j)+eps)));
        end
        
        
        
    end
    sum3=0;
    for i=1:n
        sum3=sum3+q2(i)*norm(W1'*(X(:,:,i)),'fro')-Pa2*q2(i)*log(q2(i)+eps);
    end
    ob(iter)=sum2/sum3;
    mu1=zeros(m,d2,n);
    for i=1:n
        %norm(W1'*X(:,:,i)*W2,'fro')
        mu1(:,:,i)=W1'*X(:,:,i)/(norm(W1'*X(:,:,i),'fro')+eps);
        
     end
    
    
    
    %compute A1
    A1=zeros(d1,d1);
    B1=zeros(d1,m);
     for i=1:c
        Xi = Xc{i};
        ni = nc(i);
         
        for j=1:ni
            A1=A1+dc{i}(j)*q1{i}(j)*(Xi(:,:,j)-Mean2{i})*(Xi(:,:,j)-Mean2{i})';
           
        end
     end
     for i=1:n
         B1=B1+q2(i)*X(:,:,i)*W2*mu1(:,:,i)';
     end
        %opts = optimset('Algorithm','active-set','Display','off');
         W1 = GPI(A1,ob(iter)*0.5*B1,30,W1);  
         %temp1=(ob(iter)*B1);
        %temp2= kron(eye(m),2*A1);
        %VecW1 =quadprog((temp2+temp2')/2, -temp1(:),[],[],ones(1,d1*m), d1*m, zeros(d1*m,1),[],W1(:));  
       % W1=reshape(VecW1, d1,m);
        
    
       %  temp1=(ob(iter)*B2);
       % temp2= kron(eye(m),2*A2);
        %VecW1 =quadprog((temp2+temp2')/2, -temp1(:),[],[],ones(1,d2*m), d2*m, zeros(d2*m,1),[],W2(:));  
         %W2=reshape(VecW1,d2,m);
        
        for i=1:c
        Xi = Xc{i};
        ni = nc(i);
           aa=zeros(ni,1);
           bb=zeros(ni,1);
           cc=zeros(ni,1);
         for j=1:ni
             
              cc(j)=(norm(W1'*(Xi(:,:,j)-Mean2{i}),'fro'));
              aa(j)=0.5/(cc(j)+eps);
             bb(j)=exp(-cc(j)/((Pa1*temp{i})+eps));
             %bb(j)=1;
         end
        dc{i}=aa;
        if max(bb)<=1e-10
            d=find(cc==min(cc));
            bb=zeros(ni,1);
            bb(d(1,1))=1;
        else
        q1{i}=bb/sum(bb);
        end
        %q1{i}= ones(ni,1)/ni;
        
     end
        
       for i=1:n
           q22(i)=norm(W1'*X(:,:,i),'fro');
           q2(i)=exp(q22(i)/(Pa2+eps));
           
       end
       if max(q2)>10e20
           d=find(q22==max(q22));
            q2=zeros(n,1);
            q2(d(1,1))=1;
     
           %
       else
       q2=q2/sum(q2);
       end
       %q2=ones(n,1)/n;
       if iter>1&&(abs(ob(iter)-ob(iter-1))<1e-10)
           break;
       end
        
end
   
   

