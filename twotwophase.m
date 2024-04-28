clc;
clear all;

M = 10000;

A = [1 3 -1 0 1 0;
     1 1  0 -1 0 1];
b = [3; 2];
C = [-3 -5 0 0 -M -M];

Bi = [5 6];
Bi2 = Bi;

B = A(:, Bi);
Cb = C(Bi);
alpha = B \ A;
sol = B \ b;
z = Cb * alpha - C;

[ev, ei] = min(z);
while min(z) < 0
    column = alpha(:, ei);
    m = size(column, 1);
    ratio = inf(1, m);
    for i = 1:m
        if column(i) > 0
            ratio(i) = sol(i) / column(i);
        end
    end
    [lv, li] = min(ratio);
    Bi(li) = ei;
    B = A(:, Bi);
    Cb = C(Bi);
    alpha = B \ A;
    sol = B \ b;
    z = Cb * alpha - C;
    [ev, ei] = min(z);
end

flag = 0;
for i = 1:2
    for j = 1:2
        if Bi2(i) == Bi(j)
            flag = 1;
            break;
        end
    end
    if flag == 1
        break;
    end
end

if flag == 0
    alpha = alpha(:, 1:4);
    A = [1 3 1 0; 1 1 0 1];
    C = [-3 -5 0 0];
    
    B = A(:, Bi);
    Cb = C(Bi);
    z = Cb * alpha - C;
    [ev, ei] = min(z);
    while min(z) < 0
        column = alpha(:, ei);
        m = size(column, 1);
        ratio = inf(1, m);
        for i = 1:m
            if column(i) > 0
                ratio(i) = sol(i) / column(i);
            end
        end
        [lv, li] = min(ratio);
        Bi(li) = ei;
        B = A(:, Bi);
        Cb = C(Bi);
        alpha = B \ A;
        sol = B \ b;
        z = Cb * alpha - C;
        [ev, ei] = min(z);
    end
    fprintf('Optimal Solution: %f\n', -Cb * sol);
end
