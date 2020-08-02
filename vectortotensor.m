function b = vectortotensor(x)
           [m,n]=size(x);
           d=fix(sqrt(m));
           b=zeros(d,d,n);
           for i=1:n
               b(:,:,i)=(reshape(x(:,i),d,d));
           
           end
