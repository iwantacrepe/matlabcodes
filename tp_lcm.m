clc
clear all

c=[4 2 3 5 6; 1 9 4 1 8;3 1 4 2 7;5 3 8 6 4];
a=[4 5 9 1 2];
b=[7 9 5 8 4];
sum(a)
sum(b)
m= size(c,1);
n= size(c,2);

z=0;

if sum(a) == sum(b)
    fprintf('balanced')
else
     fprintf('unbalanced')
if sum(a)<sum(b)
    c(end+1,:) = zeros(1,length(b))
    a(end+1) = sum(b) - sum(a)
    
else
    c(:,end+1)=zeros(length(a),1);
    b(end+1)=sum(a)-sum(b);
end
end

x=zeros(m,n);
initial_c = c;
for i=1:size(c,1)
    for j=1:size(c,2)
       cpq = min(c(:))
       if cpq == inf
        break
    end
    [p1 q1] = find(cpq ==c)

    xpq =min(a(p1), b(q1))
    [x1 ind] = max(xpq)
    p=p1(ind)
    q=q1(ind)

    x(p,q) = min(a(p),b(q))

    if min(a(p), b(q)) == a(p)
        b(q) = b(q)-a(p)
        a(p) = a(p)-x(p,q)
        c(p,:) = inf
    else
        a(p) = a(p) - b(q)
         b(q)= b(q) - x(p,q)
         c(:,q) = inf
    end
    end
end
for i=1:size(c,1)
    for j=1:size(c,2)
        z= z+ initial_c(i,j)*x(i,j)
    end
end
array2table(x)
fprintf('TP is %f\n',z)