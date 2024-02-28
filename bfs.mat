clc 
clear all;
A=[3 -1 1 1 0 0;
   -1 2 0 0 1 0;
   -4 3 8 0 0 1];
b=[7;6;10];
C=[-1 3 -3 0 0 0];
[m,n]=size(A)
p=nchoosek(n,m);
a=1:1:n
c=nchoosek(a,m);
sol=[];
for i=1:p
    x=zeros(1,n)
    B=A(:,c(i,:))  % Extracts the columns from A based on the current combination, forming a 3xm matrix B.
    if det(B)~= 0
        X(i,:)=B\b
        if X(i,:)>0
            x(c(i,:))=X(i,:)
            sol=[sol; x]
        end        
    end
end

[s,f]=max(C*sol');
sol(f,:)
s
