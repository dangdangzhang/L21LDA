function W1 = GPI(A1,B1,MaxIter, W)
  aa=trace(A1);
  [c,d]=size(B1);
  [m,n]=size(A1);
  tempAA=aa*eye(m)-A1;
 % W = orth(rand(size(B1)));
  for i=1:MaxIter
  BB=2*tempAA*W+2*B1;
  [U,S,V]=svd(BB);
  W=U(:,1:d)*V';
  ob(i)=trace(W'*A1*W)-2*trace(W'*B1);
  end
  
  
  W1=W;
 % plot(ob)
  
  


