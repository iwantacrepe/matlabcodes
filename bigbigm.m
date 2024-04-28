clc;
clear all;

MA = 1e5;

A = [1 3 -1 0 1 0;
     1 1  0 -1 0 1];
b = [3; 2];
C = [-3 -5 0 0 -MA -MA];

Bi = [5 6];
B = A(:, Bi);
Cb = C(Bi);

alpha = B \ A;
sol = B \ b;
Z = Cb * alpha - C;
[val, ent] = min(Z);

m = size(A, 1);
l = zeros(1, m);

for i = 1:m
    if alpha(i, ent) > 0
        l(i) = sol(i) / alpha(i, ent);
    end
end

[v, lve] = min(l);
Bi(lve) = ent;

while val < 0
    int_col = alpha(:, ent);
    [m, n] = size(int_col);
    
    ratio = inf(1, m);
    for i = 1:m
        if int_col(i, 1) > 0
            ratio(i) = sol(i, 1) / int_col(i, 1);
        end
    end
    
    [l_ele, l_ind] = min(ratio);
    Bi(l_ind) = ent;
    B = A(:, Bi);
    Cb = C(Bi);
    alpha = B \ A;
    sol = B \ b;
    Z = Cb * alpha - C;
    
    [val, ent] = min(Z);
end

opt_value = -Cb * sol;
disp('Optimal Solution:');
disp(opt_value);
disp('Basic Variables:');
disp(Bi);
disp('Final Table:');
disp(alpha);
