clc;
clear all;

A = [1 4 8 6 1 0 0; 
     4 1 2 1 0 1 0;
     2 3 1 2 0 0 1];
b = [11; 7; 2];
C = [4 6 3 1 0 0 0];

Bi = [5 6 7];
Cb = C(Bi);
B = A(:, Bi);

alpha = B\A;
Sol = B\b;
Z = Cb*alpha - C;

[e_val, e_ind] = min(Z);

m = size(A,1);
l = inf(1, m);  

for i = 1:m 
    if alpha(i, e_ind) > 0
        l(i) = Sol(i) / alpha(i, e_ind);
    end
end

[l_val, l_ind] = min(l);
Bi(l_ind) = e_ind;

while e_val < 0
    col = alpha(:, e_ind);
    [m, n] = size(col);
    ratio = inf(1, m);  

    for i = 1:m 
        if col(i, 1) > 0
            ratio(i) = Sol(i, 1) / col(i, 1);
        end
    end

    [l_val, l_ind] = min(ratio);
    Bi(l_ind) = e_ind;
    Cb = C(Bi);
    B = A(:, Bi);
    alpha = B\A;
    Sol = B\b;
    Z = Cb*alpha - C;
    
    [e_val, e_ind] = min(Z);
end

solution = Cb * Sol;
disp('Optimal Solution:');
disp(solution);
disp('Final Basic Variables Indices:');
disp(Bi);
disp('Final Tableau:');
disp(alpha);
